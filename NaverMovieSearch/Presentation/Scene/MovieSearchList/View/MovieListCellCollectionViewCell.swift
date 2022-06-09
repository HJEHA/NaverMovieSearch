//
//  MovieListCellCollectionViewCell.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import UIKit

final class MovieListCellCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCellCollectionViewCell"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let userRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.setImage(UIImage(systemName: "star.fill"), for: .selected)
        button.tintColor = .systemGray
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
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
    
    func update(item: MovieInformationItem) {
        posterImageView.image = UIImage(data: try! Data(contentsOf: URL(string: item.posterURL)!))
        titleLabel.text = item.title
        directorLabel.text = "감독: " + item.director
        actorsLabel.text = "출연: " + item.actors
        userRatingLabel.text = "평점: " + item.userRating
    }
    
    private func configureSubviews() {
        addSubview(posterImageView)
        addSubview(titleLabel)
        addSubview(directorLabel)
        addSubview(actorsLabel)
        addSubview(userRatingLabel)
        addSubview(favoriteButton)
    }
    
    private func configureSubViewsConstraint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 110)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 9 / 16)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            directorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            directorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            actorsLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 4),
            actorsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            userRatingLabel.topAnchor.constraint(equalTo: actorsLabel.bottomAnchor, constant: 4),
            userRatingLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
