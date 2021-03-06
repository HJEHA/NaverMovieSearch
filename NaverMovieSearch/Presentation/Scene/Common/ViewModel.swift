//
//  ViewModel.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

protocol ViewModel {
    associatedtype Input
    associatedtype Output
        
    func transform(_ input: Input) -> Output
}
