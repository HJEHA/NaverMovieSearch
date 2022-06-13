//
//  MovieFavoriteCoordinator.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import UIKit

final class MovieFavoriteCoordinator: Coordinator {
        
    // MARK: - Coordinator Property
    
    private weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    // MARK: - Repository
    
    init(
        parentCoordinator: AppCoordinator?,
        navigationController: UINavigationController = UINavigationController()
    ) {
        self.parentCoordinator = parentCoordinator
        self.navigationController = navigationController
    }
    
    func start() {
        let movieFavoriteViewController = MovieFavoriteViewController()
        movieFavoriteViewController.coordinator = self
        navigationController.viewControllers = [movieFavoriteViewController]
    }
    
    func present(_ viewController: UIViewController) {
        viewController.present(navigationController, animated: true)
    }
    
    func showMovieDetailView(title: String) {
        let movieDetailCoordinator = MovieDetailCoordinator(
            movieTitle: title,
            movieRepository: parentCoordinator!.movieRepository,
            parentCoordinator: self,
            navigationController: navigationController
        )
        
        print(title)
        childCoordinators.append(movieDetailCoordinator)
        movieDetailCoordinator.start()
    }
}
