//
//  NewsDetailsWebMoreTableViewCell.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import UIKit

protocol NewsDetailsWebMoreDelegate: AnyObject {
    func webMorePressed()
}

class NewsDetailsWebMoreTableViewCell: BaseTableViewCell {
    
    // MARK: - Constants
    private enum Constants {
        static let buttonTitle = "Читать полностью"
    }

    // MARK: - UI elements
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitle(Constants.buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private weak var delegate: NewsDetailsWebMoreDelegate?
    
    func configure(delegate: NewsDetailsWebMoreDelegate?) {
        setupSubviews()
        self.delegate = delegate
    }
}

// MARK: - Actions
extension NewsDetailsWebMoreTableViewCell {
    
    @objc
    func buttonPressed() {
        delegate?.webMorePressed()
    }
}

// MARK: - Private
private extension NewsDetailsWebMoreTableViewCell {
    
    func setupSubviews() {
        contentView.addSubview(moreButton)

        NSLayoutConstraint.activate([
            moreButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            moreButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            moreButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        moreButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        setupStyle()
    }
}

