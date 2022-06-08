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
        let movieTitle: Observable<String>
        
        init(movieTitle: Observable<String>) {
            self.movieTitle = movieTitle
        }
    }
    
    // MARK: - Output
    
    final class Output {
        
    }
    
    // MARK: - Properties
    
    private let useCase: MovieListUseCase
    
    // MARK: - Initializer
    
    init(useCase: MovieListUseCase = MovieListUseCase()) {
        self.useCase = useCase
    }
    
    func transform(_ input: Input) -> Output {
        
        return Output()
    }
}
