//
//  News.swift
//  Infos
//
//  Created by Михаил Зиновьев on 31.03.2023.
//

import Foundation

struct News: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
}
