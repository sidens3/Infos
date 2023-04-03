//
//  NewsListRouter.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import Foundation

protocol NewsListRouting {
    func presentNewsDetails(for article: Article)
}

class NewsListRouter: BaseRouter {}

// MARK: - NewsListRouting
extension NewsListRouter: NewsListRouting {
    func presentNewsDetails(for article: Article) {
        let controller = NewsDetailsViewController()
        controller.viewModel = NewsDetailsViewModel(data: article)
        controller.router = NewsDetailsRouter(viewController: controller)
        viewController?.show(controller, sender: nil)
    }
}
