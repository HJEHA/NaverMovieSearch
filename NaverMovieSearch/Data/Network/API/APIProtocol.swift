//
//  APIPath.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

protocol APIProtocol {
    var url: URL? { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
}

protocol Gettable: APIProtocol { }

extension Gettable {
    var method: HttpMethod {
        return .get
    }
}

enum HttpMethod: CustomStringConvertible {
    case get
    
    var description: String {
        switch self {
        case .get:
            return "GET"
        }
    }
}
