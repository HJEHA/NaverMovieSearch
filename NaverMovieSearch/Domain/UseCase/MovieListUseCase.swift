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
    let coreDataMovieRepository = CoreDataMovieRepository()
    
    init(movieRepository: MovieRepository = DefaultMovieRepository()) {
        self.movieRepository = movieRepository
    }
}

extension MovieListUseCase {
    func fetchMovies(title: String) -> Observable<[MovieInformation]> {
        return movieRepository.fetchMovies(title: title)
    }
    
    func fetchMovie(title: String) -> Observable<MovieInformation> {
        return movieRepository.fetchMovie(title: title)
    }
    
    func fetchFavoriteMovies() -> Observable<[MovieInfo]> {
        return coreDataMovieRepository.fetch()
    }
}
