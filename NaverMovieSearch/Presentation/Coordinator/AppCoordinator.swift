//
//  AppCoordinator.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    // MARK: - Coordinator Property
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Repository
    
    private let movieRepository: MovieRepository
    
    init(
        movieRepository: MovieRepository = DefaultMovieRepository(),
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.movieRepository = movieRepository
        self.navigationController = navigationController
    }
    
    func start() {
        showMovieSearchView()
    }
    
    func showMovieSearchView() {
        let movieSearchCoordinator = MovieSearchCoordinator(
            movieRepository: movieRepository,
            parentCoordinator: self,
            navigationController: navigationController
        )
        childCoordinators.append(movieSearchCoordinator)
        movieSearchCoordinator.start()
    }
    
    func showMovieDetailView(movieTitle: String) {
        let movieDetailCoordinator = MovieDetailCoordinator(
            movieTitle: movieTitle,
            movieRepository: movieRepository,
            parentCoordinator: self,
            navigationController: navigationController
        )
        childCoordinators.append(movieDetailCoordinator)
        movieDetailCoordinator.start()
    }
    
    func removeChildCoordinator(_ child: Coordinator) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
