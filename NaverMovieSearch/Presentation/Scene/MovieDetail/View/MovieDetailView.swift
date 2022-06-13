//
//  MovieDetailView.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/10.
//

import UIKit
import WebKit

final class MovieDetailView: UIView {

    lazy var movieInformationView: MovieInformationView = {
        let informationView = MovieInformationView(frame: frame)
        informationView.hiddenTitle(isHidden: true)
        informationView.translatesAutoresizingMaskIntoConstraints = false
        
        return informationView
    }()
    
    private let moviewWebView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        return webView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureSubViewsConstraint()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureSubviews()
        configureSubViewsConstraint()
    }
    
    func update(item: MovieInformation) {
        movieInformationView.update(item: item.toItem())
        
        guard let url = URL(string: item.pageLink) else {
            return
        }
        
        if moviewWebView.url == nil {
            let request = URLRequest(url: url)
            moviewWebView.load(request)
        }
    }
    
    func configureConstraint(view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureSubviews() {
        addSubview(movieInformationView)
        addSubview(moviewWebView)
    }
    
    private func configureSubViewsConstraint() {
        NSLayoutConstraint.activate([
            movieInformationView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            movieInformationView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            movieInformationView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            moviewWebView.topAnchor.constraint(equalTo: movieInformationView.bottomAnchor),
            moviewWebView.bottomAnchor.constraint(equalTo: bottomAnchor),
            moviewWebView.leadingAnchor.constraint(equalTo: leadingAnchor),
            moviewWebView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
