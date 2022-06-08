//
//  MovieSearchAPI.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

struct MovieSearchAPI: Gettable {
    let url: URL?
    let headers: [String: String]? = [
        "X-Naver-Client-Id": "SJvb2NzDMjljN6Vchaax",
        "X-Naver-Client-Secret": "JnOpikaNrF"
    ]
    
    init(by movieTitle: String) {
        var urlComponents = URLComponents(string: "https://openapi.naver.com/v1/search/movie?")
        let pageNumberQuery = URLQueryItem(name: "query", value: "\(movieTitle)")
        urlComponents?.queryItems?.append(pageNumberQuery)
        
        self.url = urlComponents?.url
    }
}
