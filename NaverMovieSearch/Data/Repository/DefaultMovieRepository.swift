//
//  DefaultMovieRepository.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

final class DefaultMovieRepository {
    let network: HTTPNetwork
    
    init(network: HTTPNetwork = HTTPNetwork()) {
        self.network = network
    }
}

extension DefaultMovieRepository: MovieRepository {
    func fetch(movieTitle: String) -> Observable<[MovieInformation]> {
        return .empty()
    }
}
