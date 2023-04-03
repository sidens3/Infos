//
//  NewsDetailsDescriptionTableViewCell.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import UIKit

class NewsDetailsDescriptionTableViewCell: BaseTableViewCell {

    // MARK: - UI elements
    let titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(description: String) {
        setupSubviews()
        titleLabel.text = description
    }
}

// MARK: - Override
extension NewsDetailsDescriptionTableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
    }
}

// MARK: - Private
private extension NewsDetailsDescriptionTableViewCell {
    
    func setupSubviews() {
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        setupStyle()
    }
}
