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

    // MARK: - Collection View
    
    private enum Section {
        case main
    }
    
    private typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, MovieInformationItem>
    private var dataSource: DiffableDataSource?
    
    // MARK: - View
    
    private let movieSearchListView = MovieSearchListView()
    
    // MARK: - ViewModel
    
    private let viewModel = MovieSearchListViewModel()
    private let disposeBag = DisposeBag()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMovieSearchListView()
        configureCollectionViewDataSource()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - View Model Methods

private extension MovieSearchListViewController {
    
    // MARK: - Bind ViewModel
    
    private func bindViewModel() {
        
        // MARK: - Input
                
        let input = MovieSearchListViewModel.Input(
            movieTitle: movieSearchListView.movieTitleTextField.rx.text.asObservable()
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
