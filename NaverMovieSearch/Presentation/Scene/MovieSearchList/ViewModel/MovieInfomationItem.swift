//
//  MovieInfomationItem.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

struct MovieInformationItem: Hashable {
    let title: String
    let posterURL: String
    let director: String
    let actors: String
    let userRating: String
    var isFavorite: Bool
}
