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
    
    let movieRepository: MovieRepository = DefaultMovieRepository()
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMovieSearchView()
    }
    
    func showMovieSearchView() {
        let movieSearchCoordinator = MovieSearchCoordinator(
            movieRepository: movieRepository,
            navigationController: navigationController
        )
        movieSearchCoordinator.start()
    }
    
    func showMovieDetailView(movieTitle: String) {
        let movieSearchCoordinator = MovieDetailCoordinator(
            movieRepository: movieRepository,
            navigationController: navigationController
        )
        movieSearchCoordinator.start()
    }
}
