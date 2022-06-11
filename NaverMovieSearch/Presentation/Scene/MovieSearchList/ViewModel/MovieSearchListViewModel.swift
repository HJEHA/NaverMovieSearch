//
//  MovieSearchListViewModel.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

final class MovieSearchListViewModel: ViewModel {
    
    // MARK: - Input
    
    final class Input {
        let movieTitle: Observable<String?>
        
        init(movieTitle: Observable<String?>) {
            self.movieTitle = movieTitle
        }
    }
    
    // MARK: - Output
    
    final class Output {
        let movieInformationItem: Observable<[MovieInformationItem]>
        
        init(movieInformationItem: Observable<[MovieInformationItem]>) {
            self.movieInformationItem = movieInformationItem
        }
    }
    
    // MARK: - Properties
    
    let useCase: MovieListUseCase
    
    // MARK: - Initializer
    
    init(useCase: MovieListUseCase = MovieListUseCase()) {
        self.useCase = useCase
    }
    
    func transform(_ input: Input) -> Output {
        let movieInfomationObservable = input.movieTitle
            .filterNil()
            .withUnretained(self)
            .flatMap { (self, title) in
                self.useCase.fetch(movieTitle: title)
            }
            .map { infomations in
                return infomations.map {
                    return MovieInformationItem(
                        title: $0.title,
                        posterURL: $0.posterURL,
                        director: $0.director.joined(separator: ", "),
                        actors: $0.actors.joined(separator: ", "),
                        userRating: $0.userRating,
                        isFavorite: $0.isFavorite
                    )
                }
            }
        
        return Output(movieInformationItem: movieInfomationObservable)
    }
}

// MARK: - Private Extension

private extension Observable {
    func filterNil<U>() -> Observable<U> where Element == U? {
        return filter { $0 != nil }.map { $0! }
    }
}
