//
//  MovieDetailViewController.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/10.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    // MARK: - View
    
    private let movieDetailView = MovieDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureMovieSearchListView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    func update(item: MovieInformationItem) {
        movieDetailView.update(item: item)
    }
}

// MARK: - Configure View

private extension MovieDetailViewController {
    func configureMovieSearchListView() {
        view.backgroundColor = .systemBackground
        view.addSubview(movieDetailView)
        movieDetailView.configureConstraint(view: view)
    }
}
