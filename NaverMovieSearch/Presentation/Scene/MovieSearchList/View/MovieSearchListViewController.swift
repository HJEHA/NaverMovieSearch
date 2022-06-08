//
//  ViewController.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/07.
//

import UIKit

final class MovieSearchListViewController: UIViewController {

    private let movieSearchListView = MovieSearchListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMovieSearchListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
}

// MARK: - Configure View

extension MovieSearchListViewController {
    func configureMovieSearchListView() {
        view.backgroundColor = .systemBackground
        view.addSubview(movieSearchListView)
        movieSearchListView.configureConstraint(view: view)
    }
}
