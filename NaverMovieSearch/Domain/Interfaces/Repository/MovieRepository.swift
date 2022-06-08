//
//  MovieRepository.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

protocol MovieRepository {
    func fetch(movieTitle: String) -> Observable<[MovieInformation]>
}
