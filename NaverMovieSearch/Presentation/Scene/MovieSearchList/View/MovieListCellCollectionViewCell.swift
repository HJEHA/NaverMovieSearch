//
//  MovieListCellCollectionViewCell.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import UIKit

final class MovieListCellCollectionViewCell: UICollectionViewCell {
    static let identifier = "MovieListCellCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
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
        titleLabel.text = item.title
    }
    
    private func configureSubviews() {
        addSubview(titleLabel)
    }
    
    private func configureSubViewsConstraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        ])
    }
}
