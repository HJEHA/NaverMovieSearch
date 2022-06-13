//
//  MovieDetailUseCase.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/10.
//

import Foundation

import RxSwift

final class MovieDetailUseCase {
    let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository = DefaultMovieRepository()) {
        self.movieRepository = movieRepository
    }
}

extension MovieDetailUseCase {
    func fetch(movieTitle: String) -> Observable<MovieInformation> {
        let aa = CoreDataMovieRepository().fetch()
            .map {
                return $0.filter {
                    $0.title == movieTitle
                }
            }
            .filter { $0.first != nil }
            .map { $0.first!.toDomain() }
        
        let dd = Observable.merge(movieRepository.fetchMovie(title: movieTitle), aa)
        
        return dd
    }
}
