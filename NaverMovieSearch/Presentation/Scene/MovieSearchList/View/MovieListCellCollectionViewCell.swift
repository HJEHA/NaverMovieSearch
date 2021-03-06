//
//  MovieListCellCollectionViewCell.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import UIKit

final class MovieListCellCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCellCollectionViewCell"
    
    private lazy var movieInformationView: MovieInformationView = {
        let infomationView = MovieInformationView(frame: frame)
        infomationView.translatesAutoresizingMaskIntoConstraints = false
        
        return infomationView
    }()
    
    var favoriteAction: (() -> Void)?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureSubViewsConstraint()
        
        movieInformationView.favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureSubviews()
        configureSubViewsConstraint()
        
        movieInformationView.favoriteButton.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
    }
    
    // MARK: - Methods
    
    func update(item: MovieInformationItem) {
        movieInformationView.update(item: item)
    }
    
    // MARK: - Configure
    
    private func configureSubviews() {
        addSubview(movieInformationView)
    }
    
    private func configureSubViewsConstraint() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: movieInformationView.heightAnchor),
            widthAnchor.constraint(equalTo: movieInformationView.widthAnchor),
            centerXAnchor.constraint(equalTo: movieInformationView.centerXAnchor),
            centerYAnchor.constraint(equalTo: movieInformationView.centerYAnchor)
        ])
    }
    
    @objc private func favoriteButtonAction() {
        favoriteAction?()
    }
}
