//
//  MovieFavoriteView.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import UIKit

final class MovieFavoriteView: UIView {
        
    lazy var movieListCollectionView: UICollectionView = {
        let listConfiguration = UICollectionLayoutListConfiguration(appearance: .plain)
        let listLayout = UICollectionViewCompositionalLayout.list(using: listConfiguration)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: listLayout)
        collectionView.keyboardDismissMode = .onDrag
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureSubViewsConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSubviews()
        configureSubViewsConstraint()
    }
    
    func configureConstraint(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureSubviews() {
        addSubview(movieListCollectionView)
    }
    
    private func configureSubViewsConstraint() {
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: topAnchor),
            movieListCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
