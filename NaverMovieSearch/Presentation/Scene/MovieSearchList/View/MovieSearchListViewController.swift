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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMovieSearchListView()
        configureCollectionViewDataSource()
        bindViewModel()
        bindCollectionView()
        bindTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - View Model Methods

private extension MovieSearchListViewController {
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        
        // MARK: - Input
                
        let input = MovieSearchListViewModel.Input(
            movieTitle: movieSearchListView.movieTitleTextField.rx.text.asObservable()
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
