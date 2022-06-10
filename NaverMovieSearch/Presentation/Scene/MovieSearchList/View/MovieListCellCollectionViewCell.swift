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
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body).bold
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
        posterImageView.loadImage(of: item.posterURL)
        titleLabel.text = item.title.replacingOccurrences(of: ["<b>", "</b>"], with: "")
        directorLabel.text = "감독: " + item.director
        actorsLabel.text = "출연: " + item.actors
        userRatingLabel.text = "평점: " + item.userRating
        setFavoriteStarColor(isFavorite: item.isFavorite)
    }
    
    private func setFavoriteStarColor(isFavorite: Bool) {
        if isFavorite {
            favoriteButton.tintColor = .systemYellow            
        } else {
            favoriteButton.tintColor = .systemGray
        }
    }
    
    // MARK: - Configure
    
    private func configureSubviews() {
        addSubview(posterImageView)
        addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(titleLabel)
        verticalStackView.addArrangedSubview(directorLabel)
        verticalStackView.addArrangedSubview(actorsLabel)
        verticalStackView.addArrangedSubview(userRatingLabel)
        
        addSubview(favoriteButton)
    }
    
    private func configureSubViewsConstraint() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalTo: verticalStackView.heightAnchor, constant: 12)
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            posterImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            posterImageView.widthAnchor.constraint(equalTo: posterImageView.heightAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            favoriteButton.leadingAnchor.constraint(equalTo: verticalStackView.trailingAnchor)
        ])
    }
}

// MARK: - Private Extension

private extension UIImageView {
    func loadImage(of key: String) {
        let cacheKey = NSString(string: key)
        if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            guard let imageURL = URL(string: key),
                  let imageData = try? Data(contentsOf: imageURL),
                  let loadedImage = UIImage(data: imageData) else {
                return
            }
            ImageCacheManager.shared.setObject(loadedImage, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = loadedImage
            }
        }
    }
}

private extension String {
    func replacingOccurrences(of: [String], with: String) -> String {
        var placingString = self
        
        of.forEach {
            placingString = placingString.replacingOccurrences(of: $0, with: with)
        }
        
        return placingString
    }
}

