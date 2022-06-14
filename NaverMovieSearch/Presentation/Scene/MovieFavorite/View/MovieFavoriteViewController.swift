//
//  MovieFavoriteViewController.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay

final class MovieFavoriteViewController: UIViewController {
    
    // MARK: - Coordinator
    
    weak var coordinator: MovieFavoriteCoordinator?
    
    // MARK: - Collection View
    
    private enum Section {
        case main
    }
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, MovieInformationItem>
    private var dataSource: DiffableDataSource?
    
    // MARK: - View
    
    private let movieFavoriteListView = MovieFavoriteView()
    
    // MARK: - ViewModel
    
    private let viewModel = MovieFavoriteViewModel()
    private let disposeBag = DisposeBag()
    
    let favoriteTitleRelay = PublishRelay<String>()
    let eventRelay = BehaviorRelay<Void>(value: Void())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMovieSearchListView()
        configureCollectionViewDataSource()
        bindViewModel()
        bindCollectionView()
        bindBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - View Model Methods

private extension MovieFavoriteViewController {
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        
        // MARK: - Input
                
        let input = MovieFavoriteViewModel.Input(
            eventRelay: eventRelay,
            favoriteTitle: favoriteTitleRelay.asObservable()
        )
        
        // MARK: - Output
        
        let output = viewModel.transform(input)
        output.movieInformationItem
            .asDriver(onErrorJustReturn: [])
            .drive(onNext: { [weak self] in
                self?.applySnapShot($0)
            })
            .disposed(by: disposeBag)
    }
    
    func bindCollectionView() {
        movieFavoriteListView.movieListCollectionView.rx.itemSelected
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
    
    func bindCellFavoriteButton(title: String) {
        favoriteTitleRelay.accept(title)
    }
    
    func bindBackButton() {
        movieFavoriteListView.closeButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (self, _) in
                self.coordinator?.dismiss()
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Configure View

private extension MovieFavoriteViewController {
    func configureMovieSearchListView() {
        view.backgroundColor = .systemBackground
        view.addSubview(movieFavoriteListView)
        movieFavoriteListView.configureConstraint(view: view)
    }
}

// MARK: - Configure Collection View

private extension MovieFavoriteViewController {
    func configureCollectionViewDataSource() {
        typealias CellRegistration = UICollectionView.CellRegistration<MovieListCellCollectionViewCell, MovieInformationItem>
        
        let coinListRegistration = CellRegistration { cell, indexPath, item in
            cell.update(item: item)
            cell.favoriteAction = { [weak self] in
                self?.bindCellFavoriteButton(title: item.title)
            }
        }
        
        dataSource = DiffableDataSource(collectionView: movieFavoriteListView.movieListCollectionView) { collectionView, indexPath, item in
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
