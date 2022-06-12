//
//  AppCoordinator.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
    }
    
    func start() {
        let movieSearchCoordinator = MovieSearchCoordinator(navigationController: navigationController)
        movieSearchCoordinator.start()
    }
}
