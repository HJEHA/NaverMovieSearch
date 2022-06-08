//
//  HttpNetwork.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/08.
//

import Foundation

import RxSwift

final class HttpNetwork {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func fetch(_ api: APIProtocol) -> Observable<Data> {
        guard let urlRequest = URLRequest(api: api) else {
            return .empty()
        }
        
        return Observable<Data>.create { [weak self] emmiter in
            let task = self?.session.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    emmiter.onError(HttpNetworkError.unknownError(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    emmiter.onError(HttpNetworkError.invalidResponse)
                    return
                }
                
                guard (200..<300).contains(httpResponse.statusCode) else {
                    emmiter.onError(HttpNetworkError.abnormalStatusCode(httpResponse.statusCode))
                    return
                }
                
                guard let data = data else {
                    emmiter.onError(HttpNetworkError.invalidResponse)
                    return
                }
                
                emmiter.onNext(data)
                emmiter.onCompleted()
            }
            task?.resume()
            
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}

private extension URLRequest {
    init?(api: APIProtocol) {
        guard let url = api.url else {
            return nil
        }
        
        self.init(url: url)
        self.httpMethod = "\(api.method)"
        
        api.headers?.forEach({ key, value in
            self.addValue(value, forHTTPHeaderField: key)
        })
    }
}
