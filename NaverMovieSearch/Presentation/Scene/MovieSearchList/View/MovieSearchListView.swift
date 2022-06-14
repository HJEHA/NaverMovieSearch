//
//  MovieSearchListView.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import UIKit

final class MovieSearchListView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "네이버 영화 검색"
        label.font = .preferredFont(forTextStyle: .title2).bold
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("즐겨찾기", for: .normal)
        button.setTitle("즐겨찾기", for: .selected)
        button.setTitleColor(.label, for: .normal)
        button.setTitleColor(.label, for: .selected)
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.tintColor = .systemYellow
        button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints =  false
        
        return button
    }()
    
    let movieTitleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "영화 제목을 입력해주세요."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
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
        addSubview(favoriteButton)
        addSubview(movieTitleTextField)
        addSubview(movieListCollectionView)
    }
    
    private func configureSubViewsConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.heightAnchor.constraint(equalTo: titleLabel.heightAnchor),
            favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            movieTitleTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),           
            movieTitleTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            movieTitleTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            movieTitleTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.05),
        ])
        
        NSLayoutConstraint.activate([
            movieListCollectionView.topAnchor.constraint(equalTo: movieTitleTextField.bottomAnchor, constant: 4),
            movieListCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieListCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieListCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
