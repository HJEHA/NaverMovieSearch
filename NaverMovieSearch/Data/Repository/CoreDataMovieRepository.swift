//
//  CoreDataMovieRepository.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import Foundation

import RxSwift

final class CoreDataMovieRepository {
    func fetch() -> Observable<[MovieInfo]> {
        return Observable.create { emitter in
            let movieInfo = CoreDataManager.shared.fetch(request: MovieInfo.fetchRequest())
            
            emitter.onNext(movieInfo)
            emitter.onCompleted()
            return Disposables.create()
        }
    }
    
    func delete(title: String) {
        let request = MovieInfo.fetchRequest(title: title)
        
        CoreDataManager.shared.delete(request: request)
    }
    
    func save(movieInformation: MovieInformation) {
        guard exist(title: movieInformation.title) == false else {
            return
        }
        
        let movieInto = MovieInfo(context: CoreDataManager.shared.context)
        movieInto.title  = movieInformation.title
        movieInto.posterURL = movieInformation.posterURL
        movieInto.pageLink = movieInformation.pageLink
        movieInto.director = movieInformation.director
        movieInto.actors = movieInformation.actors
        movieInto.userRating = movieInformation.userRating
        movieInto.isFavorite = true
        
        CoreDataManager.shared.saveContext()
    }
    
    func exist(title: String) -> Bool {
        let request = MovieInfo.fetchRequest(title: title)
        
        return !CoreDataManager.shared.fetch(request: request).isEmpty
    }
}
