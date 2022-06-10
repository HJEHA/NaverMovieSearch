//
//  DefaultMovieRepository.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

final class DefaultMovieRepository: MovieRepository {
    let network: HTTPNetwork
    private(set) var movieInformationObservable: Observable<[MovieInformation]>?
    
    init(network: HTTPNetwork = HTTPNetwork()) {
        self.network = network
    }
}

extension DefaultMovieRepository {
    func fetchMovies(title: String) -> Observable<[MovieInformation]> {
        let movieSearchAPI = MovieSearchAPI(by: title)

        movieInformationObservable = network.fetch(movieSearchAPI)
            .map { data -> [MovieInformation] in
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let decodedType = try? decoder.decode(MovieSearchResponseDTO.self, from: data)
                
                return decodedType?.toDomain() ?? []
            }
        
        return movieInformationObservable ?? Observable.empty()
    }
    
    func fetchMovie(title: String) -> Observable<MovieInformation> {
        let result = movieInformationObservable?.flatMapFirst { infos -> Observable<MovieInformation> in
            guard let info = infos.filter({ $0.title == title }).first else {
                return Observable.empty()
            }
            
            return Observable.just(info)
        }
        
        return result ?? .empty()
    }
}
