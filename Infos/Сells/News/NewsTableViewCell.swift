//
//  NewsTableViewCell.swift
//  Infos
//
//  Created by Михаил Зиновьев on 31.03.2023.
//

import UIKit

class NewsTableViewCell: BaseTableViewCell {

    // MARK: - UI elements
    private var newsImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "arrow.triangle.2.circlepath.camera")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
    func configure(for article: Article) {
        setupSubviews()
        
        
    }
}

// MARK: - Private
private extension NewsTableViewCell {
    
    func setupSubviews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -16),
            newsImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            newsImageView.heightAnchor.constraint(equalToConstant: 24),
            newsImageView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        setupStyle()
    }
}
