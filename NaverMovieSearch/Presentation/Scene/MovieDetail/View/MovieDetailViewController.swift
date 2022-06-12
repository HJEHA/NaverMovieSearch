//
//  MovieDetailViewController.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/10.
//

import UIKit

import RxSwift
import RxCocoa
import RxRelay

final class MovieDetailViewController: UIViewController {

    // MARK: - Coordinator
    
    weak var coordinator: MovieDetailCoordinator?
    
    // MARK: - View
    
    private let movieDetailView = MovieDetailView()
    
    // MARK: - ViewModel
    
    var viewModel: MovieDetailViewModel?
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMovieSearchListView()
        configureBackButton()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    deinit {
        coordinator?.popMovieDetailView()
    }
    
    func update(item: MovieInformation) {
        movieDetailView.update(item: item)
        configureTitle(to: item.title)
    }
}

// MARK: - View Model Methods

private extension MovieDetailViewController {
    
    // MARK: - Bind ViewModel
    
    func bindViewModel() {
        
        // MARK: - Input
        
        let isFavoriteRelay = BehaviorRelay<Bool>(value: false)
        
        movieDetailView.movieInformationView.favoriteButton.rx.tap
            .scan(movieDetailView.movieInformationView.favoriteButton.isSelected) { lastState, newState in !lastState }
            .subscribe(onNext: {
                isFavoriteRelay.accept($0)
            })
            .disposed(by: disposeBag)
                
        let input = MovieDetailViewModel.Input(
            isFavorite: isFavoriteRelay.asObservable()
        )
        
        // MARK: - Output
        
        guard let viewModel = viewModel else {
            return
        }
        
        let output = viewModel.transform(input)
        output.movieInformation
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                self?.update(item: $0)
            })
            .disposed(by: disposeBag)
    }
}

// MARK: - Configure View

private extension MovieDetailViewController {
    func configureMovieSearchListView() {
        view.backgroundColor = .systemBackground
        view.addSubview(movieDetailView)
        movieDetailView.configureConstraint(view: view)
    }
    
    func configureTitle(to title: String) {
        let titleView: UILabel = {
            let label = UILabel()
            label.text = title
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
