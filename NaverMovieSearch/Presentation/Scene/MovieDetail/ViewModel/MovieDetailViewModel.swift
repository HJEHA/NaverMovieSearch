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
        
    }
    
    // MARK: - Output
    
    final class Output {
        
    }
    
    // MARK: - Properties
    
    private let useCase: MovieDetailUseCase
    
    // MARK: - Initializer
    
    init(useCase: MovieDetailUseCase = MovieDetailUseCase()) {
        self.useCase = useCase
    }
    
    func transform(_ input: Input) -> Output {
        
        
        return Output()
    }
}
