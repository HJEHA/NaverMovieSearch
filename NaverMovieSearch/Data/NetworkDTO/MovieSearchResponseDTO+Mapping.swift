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
        
        case movieInformations = "items"
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

// MARK: - Mapping

extension MovieSearchResponseDTO {
    func toDomain() -> [MovieInformation] {
        return movieInformations.map {
            let actors = $0.actor.components(separatedBy: "|").filter { $0 != "" }
            
            return MovieInformation(
                title: $0.title,
                posterURL: $0.image,
                pagelink: $0.link,
                director: $0.director,
                actors: actors,
                userRating: $0.userRating,
                isFavorite: false
            )
        }
    }
}
