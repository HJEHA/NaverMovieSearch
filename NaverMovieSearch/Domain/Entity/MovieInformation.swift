//
//  MovieInformation.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

struct MovieInformation {
    let title: String
    let posterURL: String
    let pageLink: String
    let director: String
    let actors: String
    let userRating: String
    var isFavorite: Bool
}

extension MovieInformation {
    func toItem() -> MovieInformationItem {
        return MovieInformationItem(
            title: title,
            posterURL: posterURL,
            director: director,
            actors: actors,
            userRating: userRating,
            isFavorite: isFavorite
        )
    }
}
