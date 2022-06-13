//
//  MovieFavoriteUseCase.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import Foundation

import RxSwift

final class MovieFavoriteUseCase {
    let coreDataMovieRepository: CoreDataMovieRepository
    
    init(coreDataMovieRepository: CoreDataMovieRepository = CoreDataMovieRepository()) {
        self.coreDataMovieRepository = coreDataMovieRepository
    }
}

extension MovieFavoriteUseCase {
    func fetch() -> Observable<[MovieInfo]> {
        return coreDataMovieRepository.fetch()
    }
    
    func delete(title: String) {
        coreDataMovieRepository.delete(title: title)
    }
    
    func save(movieInformation: MovieInformation) {
        coreDataMovieRepository.save(movieInformation: movieInformation)
    }
}
