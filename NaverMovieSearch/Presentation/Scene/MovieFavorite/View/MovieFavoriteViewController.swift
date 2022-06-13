//
//  MovieFavoriteViewController.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import UIKit

import RxSwift

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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configureBackButton()
        
        configureMovieSearchListView()
        configureCollectionViewDataSource()
        bindViewModel()
        bindCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - View Model Methods

private extension MovieFavoriteViewController {
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        
        // MARK: - Input
                
        let input = MovieFavoriteViewModel.Input(
            
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
                
                print(movieTitle)
                
                self.coordinator?.showMovieDetailView(title: movieTitle)
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
    
    func configureTitle() {
        let titleView: UILabel = {
            let label = UILabel()
            label.text = "즐겨찾기 목록"
            label.font = .preferredFont(forTextStyle: .title3).bold
            
            return label
        }()
        
        navigationItem.titleView = titleView
    }
    
    func configureBackButton() {
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = String()
    }
}

// MARK: - Configure Collection View

private extension MovieFavoriteViewController {
    func configureCollectionViewDataSource() {
        typealias CellRegistration = UICollectionView.CellRegistration<MovieListCellCollectionViewCell, MovieInformationItem>
        
        let coinListRegistration = CellRegistration { cell, indexPath, item in
            cell.update(item: item)
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
