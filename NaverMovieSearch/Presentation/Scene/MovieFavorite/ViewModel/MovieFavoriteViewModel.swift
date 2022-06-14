//
//  MovieFavoriteViewModel.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import Foundation

import RxSwift
import RxRelay

final class MovieFavoriteViewModel: ViewModel {
    
    // MARK: - Input
    
    final class Input {
        let eventRelay: BehaviorRelay<Void>
        let favoriteTitle: Observable<String>
        
        init(
            eventRelay: BehaviorRelay<Void>,
            favoriteTitle: Observable<String>
        ) {
            self.eventRelay = eventRelay
            self.favoriteTitle = favoriteTitle
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
    
    private let useCase: MovieFavoriteUseCase
    private var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(useCase: MovieFavoriteUseCase = MovieFavoriteUseCase()) {
        self.useCase = useCase
    }
    
    func transform(_ input: Input) -> Output {
        let movieInfomationObservable = input.eventRelay
            .withUnretained(self)
            .flatMap { (self, _) -> Observable<[MovieInfo]> in
                self.useCase.fetch()
            }
            .map { informations in
                return informations.map {
                    return $0.toItem()
                }
            }
        
        input.favoriteTitle
            .subscribe(onNext: { title in
                CoreDataMovieRepository().delete(title: title)
                input.eventRelay.accept(Void())
            })
            .disposed(by: disposeBag)
        
        return Output(movieInformationItem: movieInfomationObservable)
    }
}
