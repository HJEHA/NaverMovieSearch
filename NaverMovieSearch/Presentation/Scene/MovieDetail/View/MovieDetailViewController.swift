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
        configureBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    func update(item: MovieInformationItem) {
        movieDetailView.update(item: item)
        configureTitle(to: item.title)
    }
}

// MARK: - Configure View

private extension MovieDetailViewController {
    func configureMovieSearchListView() {
        view.backgroundColor = .systemBackground
        view.addSubview(movieDetailView)
        movieDetailView.configureConstraint(view: view)
    }
    
    func configureTitle(to title: String) {
        let titleView: UILabel = {
            let label = UILabel()
            label.text = title
            label.font = .preferredFont(forTextStyle: .title3).bold
            
            return label
        }()
        
        navigationItem.titleView = titleView
    }
    
    func configureBackButton() {
        navigationController?.navigationBar.tintColor = .label
        navigationController?.navigationBar.topItem?.title = String()
    }
}
