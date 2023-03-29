//
//  BaseViewController.swift
//  Infos
//
//  Created by Михаил Зиновьев on 29.03.2023.
//

import UIKit

class BaseViewController: UIViewController {}

// MARK: - Life cycle
extension BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }
}

// MARK: - Alerts
extension BaseViewController {

    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            actions.forEach { alert.addAction($0) }
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Private
private extension BaseViewController {
    
    func setupStyle() {
        view.backgroundColor = .systemBackground
    }
}
