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
    let coreDataMovieRepository = CoreDataMovieRepository()
    
    init(movieRepository: MovieRepository = DefaultMovieRepository()) {
        self.movieRepository = movieRepository
    }
}

extension MovieDetailUseCase {
    func fetch(movieTitle: String) -> Observable<MovieInformation> {
        let coreDataObservable = coreDataMovieRepository.fetch()
            .map {
                return $0.filter {
                    $0.title == movieTitle
                }
            }
            .filter { $0.first != nil }
            .map { $0.first!.toDomain() }
        
        return Observable.merge(movieRepository.fetchMovie(title: movieTitle), coreDataObservable)
    }
    
    func delete(title: String) {
        coreDataMovieRepository.delete(title: title)
    }
    
    func save(movieInformation: MovieInformation) {
        coreDataMovieRepository.save(movieInformation: movieInformation)
    }
    
    func exist(title: String) -> Bool {
        return coreDataMovieRepository.exist(title: title)
    }
}
