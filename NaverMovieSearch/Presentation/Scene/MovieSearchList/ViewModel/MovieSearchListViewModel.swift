//
//  MovieSearchListViewModel.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift
import RxRelay

final class MovieSearchListViewModel: ViewModel {
    
    // MARK: - Input
    
    final class Input {
        let movieTitle: Observable<String?>
        let eventRelay: BehaviorRelay<Void>
        let isFavorite: Observable<Bool>
        let favoriteTitle: Observable<String>
        
        init(
            movieTitle: Observable<String?>,
            eventRelay: BehaviorRelay<Void>,
            isFavorite: Observable<Bool>,
            favoriteTitle: Observable<String>
        ) {
            self.movieTitle = movieTitle
            self.eventRelay = eventRelay
            self.isFavorite = isFavorite
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
    
    private let useCase: MovieListUseCase
    private var disposeBag = DisposeBag()
    
    // MARK: - Initializer
    
    init(useCase: MovieListUseCase = MovieListUseCase()) {
        self.useCase = useCase
    }
    
    func transform(_ input: Input) -> Output {
        let fetchMovieObservable = input.movieTitle
            .filterNil()
            .withUnretained(self)
            .flatMap { (self, title) in
                self.useCase.fetchMovies(title: title)
            }
        
        let movieInfomationObservable = Observable.combineLatest(fetchMovieObservable, input.eventRelay.asObservable())
            .withUnretained(self)
            .map { (self, informations) -> [MovieInformationItem] in
                var favoriteTitle = [String]()
                
                self.useCase.fetchFavoriteMovies()
                    .subscribe(onNext: {
                        favoriteTitle = $0.map { $0.title }
                    })
                    .disposed(by: self.disposeBag)
                
                return informations.0.map {
                    return MovieInformationItem(
                        title: $0.title,
                        posterURL: $0.posterURL,
                        director: $0.director,
                        actors: $0.actors,
                        userRating: $0.userRating,
                        isFavorite: favoriteTitle.contains($0.title)
                    )
                }.sorted { $0.title > $1.title }
            }
        
        let favoriteInfo = input.favoriteTitle
            .withUnretained(self)
            .flatMap { (self, title) in
                self.useCase.fetchMovie(title: title)
            }
        
        Observable.zip(input.isFavorite, favoriteInfo)
            .subscribe(onNext: { (isFavorite, info) in
                if isFavorite {
                    CoreDataMovieRepository().save(movieInformation: info)
                } else {
                    CoreDataMovieRepository().delete(title: info.title)
                }
                input.eventRelay.accept(Void())
            })
            .disposed(by: disposeBag)
        
        return Output(movieInformationItem: movieInfomationObservable)
    }
}

// MARK: - Private Extension

private extension Observable {
    func filterNil<U>() -> Observable<U> where Element == U? {
        return filter { $0 != nil }.map { $0! }
    }
}
