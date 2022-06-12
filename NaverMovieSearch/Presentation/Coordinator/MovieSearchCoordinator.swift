//
//  MovieSearchCoordinator.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/12.
//

import UIKit

final class MovieSearchCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieSearchViewController = MovieSearchListViewController()
        movieSearchViewController.coordinator = self
        navigationController.show(movieSearchViewController, sender: nil)
    }
}
