//
//  MovieSearchResponseDTO+Mapping.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/07.
//

import Foundation

struct MovieSearchResponseDTO: Decodable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let movieInformations: [MovieInformationDTO]
    
    enum CodingKeys: String, CodingKey {
        case lastBuildDate
        case total
        case start
        case display
        
        case movieInformations = "item"
    }
}

extension MovieSearchResponseDTO {
    struct MovieInformationDTO: Decodable {
        let title: String
        let link: String
        let image: String
        let subtitle: String
        let productionYear: String
        let director: String
        let actor: String
        let userRating: String
        
        enum CodingKeys: String, CodingKey {
            case title
            case link
            case image
            case subtitle
            case director
            case actor
            case userRating
            
            case productionYear = "pubDate"
        }
    }
}
