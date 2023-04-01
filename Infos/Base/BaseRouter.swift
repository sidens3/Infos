//
//  BaseRouter.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import Foundation

class BaseRouter {
    
    weak var viewController: BaseViewController?

    public init(viewController: BaseViewController) {
        self.viewController = viewController
//        viewController.segueHandler = { [weak self] (segue, sender) in
//            self?.prepare(for: segue, sender: sender)
//            NotificationCenter.default.post(Notification(name: Notification.visibleControllerChanged))
//        }
    }
}
