//
//  NetworkManager.swift
//  Infos
//
//  Created by Михаил Зиновьев on 31.03.2023.
//

import Foundation
import Alamofire

class NetworkManager {
    
    // MARK: - Constants
    private enum Constants {
        static let scheme = "https"
        static let host = "newsapi.org"
        static let endpointVersion = "v2"
        static let token = "2379752a180e45a487492621b336531c"
    }
    
    var newsURL: URLComponents {
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.scheme
        urlComponents.host = Constants.host
        urlComponents.path = "/\(Constants.endpointVersion)"
        urlComponents.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.token)
        ]
        return urlComponents
    }
    
    func performRequest<T: Decodable>(url: URLComponents, completion: @escaping(Result<T, Error>) -> Void )  {
        AF.request(url)
            .validate()
            .responseDecodable(of: T.self) { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    completion(.success(value))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
