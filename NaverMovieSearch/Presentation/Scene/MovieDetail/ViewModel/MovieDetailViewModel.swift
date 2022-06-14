//
//  MovieDetailViewModel.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/10.
//

import Foundation

import RxSwift

final class MovieDetailViewModel: ViewModel {
    
    // MARK: - Input
    
    final class Input {
        let isFavorite: Observable<Bool>
        
        init(isFavorite: Observable<Bool>) {
            self.isFavorite = isFavorite
        }
    }
    
    // MARK: - Output
    
    final class Output {
        let movieInformation: Observable<MovieInformation>
        
        init(movieInformation: Observable<MovieInformation>) {
            self.movieInformation = movieInformation
        }
    }
    
    // MARK: - Properties
    private let movieTitle: String
    let isFavorite: Bool
    private let useCase: MovieDetailUseCase
    
    // MARK: - Initializer
    
    init(movieTitle: String, useCase: MovieDetailUseCase = MovieDetailUseCase()) {
        self.movieTitle = movieTitle
        self.useCase = useCase
        self.isFavorite = useCase.exist(title: movieTitle)
    }
    
    func transform(_ input: Input) -> Output {
        let movieInformation = Observable.combineLatest(input.isFavorite, useCase.fetch(movieTitle: movieTitle))
            .map { [weak self] (isFavorite, informaton) -> MovieInformation in
                let informaton = MovieInformation(
                    title: informaton.title,
                    posterURL: informaton.posterURL,
                    pageLink: informaton.pageLink,
                    director: informaton.director,
                    actors: informaton.actors,
                    userRating: informaton.userRating,
                    isFavorite: isFavorite
                )
                
                if isFavorite {
                    self?.useCase.save(movieInformation: informaton)
                } else {
                    self?.useCase.delete(title: informaton.title)
                }
                
                return informaton
            }
        
        return Output(
            movieInformation: movieInformation
        )
    }
}
