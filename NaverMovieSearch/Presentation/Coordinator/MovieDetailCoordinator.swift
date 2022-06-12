//
//  MovieDetailCoordinator.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/12.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    
    // MARK: - Coordinator Property
    
    private weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Property
    
    private let movieTitle: String
    private let movieRepository: MovieRepository
    
    init(
        movieTitle: String,
        movieRepository: MovieRepository,
        parentCoordinator: AppCoordinator?,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.movieTitle = movieTitle
        self.movieRepository = movieRepository
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let movieDetailUseCase = MovieDetailUseCase(movieRepository: movieRepository)
        let movieDetailViewModel = MovieDetailViewModel(
            movieTitle: movieTitle,
            useCase: movieDetailUseCase
        )
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.viewModel = movieDetailViewModel
        movieDetailViewController.coordinator = self
        navigationController.show(movieDetailViewController, sender: nil)
    }
    
    func popMovieDetailView() {
        parentCoordinator?.removeChildCoordinator(self)
    }
}
