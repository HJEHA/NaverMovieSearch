//
//  ViewController.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/07.
//

import UIKit

import RxSwift
import RxCocoa

final class MovieSearchListViewController: UIViewController {
    
    // MARK: - Coordinator
    
    weak var coordinator: MovieSearchCoordinator?
    
    // MARK: - Collection View
    
    private enum Section {
        case main
    }
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, MovieInformationItem>
    private var dataSource: DiffableDataSource?
    
    // MARK: - View
    
    private let movieSearchListView = MovieSearchListView()
    
    // MARK: - ViewModel
    
    var viewModel: MovieSearchListViewModel?
    private let disposeBag = DisposeBag()
    
    let isFavoriteRelay = PublishRelay<Bool>()
    let favoriteTitleRelay = PublishRelay<String>()
    let eventRelay = BehaviorRelay<Void>(value: Void())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMovieSearchListView()
        configureCollectionViewDataSource()
        bindViewModel()
        bindCollectionView()
        bindFavoriteButton()
        bindTapGesture()
        
        CoreDataMovieRepository().fetch()
            .subscribe(onNext: {
                $0.forEach {
                    print($0.title)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
        eventRelay.accept(Void())
    }
}

// MARK: - View Model Methods

private extension MovieSearchListViewController {
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        
        // MARK: - Input
                
        let input = MovieSearchListViewModel.Input(
            movieTitle: movieSearchListView.movieTitleTextField.rx.text.asObservable(),
            eventRelay: eventRelay,
            isFavorite: isFavoriteRelay.asObservable(),
            favoriteTitle: favoriteTitleRelay.asObservable()
        )
        
        // MARK: - Output
        
        guard let viewModel = viewModel else {
            return
        }
        
        let output = viewModel.transform(input)
        output.movieInformationItem
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] in
                self?.applySnapShot($0)
            })
            .disposed(by: disposeBag)
    }
    
    func bindFavoriteButton() {
        movieSearchListView.favoriteButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (self, _) in
                self.coordinator?.showMovieFavoriteView(self)
            })
            .disposed(by: disposeBag)
    }
    
    func bindCollectionView() {
        movieSearchListView.movieListCollectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] in
                guard let self = self,
                      let movieTitle = self.dataSource?.itemIdentifier(for: $0)?.title
                else {
                    return
                }
                
                self.coordinator?.showMovieDetailView(title: movieTitle)
            })
            .disposed(by: disposeBag)
    }
    
    func bindCellFavoriteButton(isFavorite: Bool, title: String) {
        isFavoriteRelay.accept(isFavorite)
        favoriteTitleRelay.accept(title)
    }
}

// MARK: - Configure View

private extension MovieSearchListViewController {
    func configureMovieSearchListView() {
        view.backgroundColor = .systemBackground
        view.addSubview(movieSearchListView)
        movieSearchListView.configureConstraint(view: view)
    }
}

// MARK: - Configure Collection View

private extension MovieSearchListViewController {
    func configureCollectionViewDataSource() {
        typealias CellRegistration = UICollectionView.CellRegistration<MovieListCellCollectionViewCell, MovieInformationItem>
        
        let coinListRegistration = CellRegistration { cell, indexPath, item in
            cell.update(item: item)
            cell.favoriteAction = { [weak self] in
                self?.bindCellFavoriteButton(isFavorite: !item.isFavorite, title: item.title)
            }
        }
        
        dataSource = DiffableDataSource(collectionView: movieSearchListView.movieListCollectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(
                using: coinListRegistration,
                for: indexPath,
                item: item
            )
        }
    }
    
    func applySnapShot(_ items: [MovieInformationItem]) {
        var snapShot = NSDiffableDataSourceSnapshot<Section, MovieInformationItem>()
        
        snapShot.appendSections([.main])
        snapShot.appendItems(items, toSection: .main)
        
        dataSource?.apply(snapShot)
    }
}


// MARK: - Keyboard
extension MovieSearchListViewController {
    private func bindTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: nil)
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
}
