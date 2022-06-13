//
//  MovieFavoriteViewModel.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import Foundation

import RxSwift

final class MovieFavoriteViewModel: ViewModel {
    
    // MARK: - Input
    
    final class Input {
        
    }
    
    // MARK: - Output
    
    final class Output {
        let movieInformationItem: Observable<[MovieInformationItem]>
        
        init(movieInformationItem: Observable<[MovieInformationItem]>) {
            self.movieInformationItem = movieInformationItem
        }
    }
    
    // MARK: - Properties
    
    private let useCase: MovieFavoriteUseCase
    
    // MARK: - Initializer
    
    init(useCase: MovieFavoriteUseCase = MovieFavoriteUseCase()) {
        self.useCase = useCase
    }
    
    func transform(_ input: Input) -> Output {
        let movieInfomationObservable = useCase.fetch()
            .map { informations in
                return informations.map {
                    return $0.toItem()
                }
            }
        
        return Output(movieInformationItem: movieInfomationObservable)
    }
}
