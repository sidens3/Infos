//
//  NewsDetailsRouter.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import Foundation

protocol NewsDetailsRouting {
    func presentWebDetails(for urlString: String)
}

class NewsDetailsRouter: BaseRouter {}

// MARK: - NewsListRouting
extension NewsDetailsRouter: NewsDetailsRouting {
    
    func presentWebDetails(for urlString: String) {
        let controller = NewsWebDetailsViewController()
        controller.url = urlString
        viewController?.show(controller, sender: nil)
    }
}
