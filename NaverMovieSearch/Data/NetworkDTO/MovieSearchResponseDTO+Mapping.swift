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
            let director = $0.director.componentsNotEmpty(separatedBy: "|").joined(separator: ", ")
            let actors = $0.actor.componentsNotEmpty(separatedBy: "|").joined(separator: ", ")
            
            return MovieInformation(
                title: $0.title.replacingOccurrences(of: ["<b>", "</b>"], with: ""),
                posterURL: $0.image,
                pageLink: $0.link,
                director: director,
                actors: actors,
                userRating: $0.userRating,
                isFavorite: false
            )
        }
    }
}

// MARK: - Private Extension

private extension String {
    func componentsNotEmpty(separatedBy: String) -> [String] {
        return self.components(separatedBy: separatedBy).filter { $0 != "" }
    }
    
    func replacingOccurrences(of: [String], with: String) -> String {
        var placingString = self
        
        of.forEach {
            placingString = placingString.replacingOccurrences(of: $0, with: with)
        }
        
        return placingString
    }
}
