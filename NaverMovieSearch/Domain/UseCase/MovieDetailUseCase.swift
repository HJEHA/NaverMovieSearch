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
        return movieRepository.fetch(movieTitle: movieTitle)
    }
}
