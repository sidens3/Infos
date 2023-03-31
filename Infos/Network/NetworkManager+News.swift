//
//  NetworkManager+News.swift
//  Infos
//
//  Created by Михаил Зиновьев on 31.03.2023.
//

import Foundation
import Alamofire

protocol NewsManaging {
    func requestNews(query: String, completion: @escaping ((Result<News, Error>) -> Void ))
}

extension NetworkManager: NewsManaging {
    func requestNews(query: String, completion: @escaping ((Result<News, Error>) -> Void)) {
        var url = newsURL
        url.path.append("&\(query)")
        performRequest(url: url, completion: completion)
    }
}
