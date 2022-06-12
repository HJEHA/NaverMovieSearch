//
//  MovieDetailCoordinator.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/12.
//

import UIKit

final class MovieDetailCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieDetailViewController = MovieDetailViewController()
        movieDetailViewController.coordinator = self
        navigationController.show(movieDetailViewController, sender: nil)
    }
}
