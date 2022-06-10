//
//  MovieRepository.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

protocol MovieRepository {
    var movieInformationObservable: Observable<[MovieInformation]>? { get }
    
    func fetchMovies(title: String) -> Observable<[MovieInformation]>
    func fetchMovie(title: String) -> Observable<MovieInformation>
}
