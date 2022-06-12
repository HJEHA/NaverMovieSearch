//
//  MovieSearchCoordinator.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/12.
//

import UIKit

final class MovieSearchCoordinator: Coordinator {
    
    
    // MARK: - Coordinator Property
    
    private weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Repository
    
    private let movieRepository: MovieRepository
    
    init(
        movieRepository: MovieRepository,
        parentCoordinator: AppCoordinator?,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.movieRepository = movieRepository
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let movieSearchUseCase = MovieListUseCase(movieRepository: movieRepository)
        let movieSearchViewModel = MovieSearchListViewModel(useCase: movieSearchUseCase)
        let movieSearchViewController = MovieSearchListViewController()
        movieSearchViewController.viewModel = movieSearchViewModel
        movieSearchViewController.coordinator = self
        navigationController.show(movieSearchViewController, sender: nil)
    }
    
    func showMovieDetailView(title: String) {
        parentCoordinator?.showMovieDetailView(movieTitle: title)
    }
}
