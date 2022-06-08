//
//  DefaultMovieRepository.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

final class DefaultMovieRepository {
    let network: HTTPNetwork
    
    init(network: HTTPNetwork = HTTPNetwork()) {
        self.network = network
    }
}

extension DefaultMovieRepository: MovieRepository {
    func fetch(movieTitle: String) -> Observable<[MovieInformation]> {
        let movieSearchAPI = MovieSearchAPI(by: movieTitle)

        return network.fetch(movieSearchAPI)
            .map { data -> [MovieInformation] in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedType = try? decoder.decode(MovieSearchResponseDTO.self, from: data)
                
                return decodedType?.toDomain() ?? []
            }
    }
}
