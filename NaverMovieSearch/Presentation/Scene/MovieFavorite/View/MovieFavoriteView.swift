//
//  MovieFavoriteView.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import UIKit

final class MovieFavoriteView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "즐겨찾기 목록"
        label.font = .preferredFont(forTextStyle: .title2).bold
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.setImage(UIImage(systemName: "xmark"), for: .selected)
        button.tintColor = .label
        
        button.translatesAutoresizingMaskIntoConstraints =  false
        
        return button
    }()
    
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
        addSubview(titleLabel)
        addSubview(movieListCollectionView)
        addSubview(closeButton)
    }
    
    private func configureSubViewsConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            closeButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            closeButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            movieListCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
