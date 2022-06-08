//
//  MovieListUseCase.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

final class MovieListUseCase {
    let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository = DefaultMovieRepository()) {
        self.movieRepository = movieRepository
    }
}

extension MovieListUseCase {
    func fetch(movieTitle: String) -> Observable<[MovieInformation]> {
        return movieRepository.fetch(movieTitle: movieTitle)
    }
}
