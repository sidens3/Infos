//
//  NewsTableViewCell.swift
//  Infos
//
//  Created by Михаил Зиновьев on 31.03.2023.
//

import UIKit
import Kingfisher

class NewsTableViewCell: BaseTableViewCell {

    // MARK: - UI elements
    private var newsImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "placeholder")
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
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
        fetchImage(by: article.urlToImage ?? "") { [weak self] image in
            self?.newsImageView.image = image
        }
        titleLabel.text = article.title
    }
}

// MARK: - Override
extension NewsTableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImageView.image = UIImage(named: "placeholder")
        titleLabel.text = ""
    }
}

// MARK: - Private
private extension NewsTableViewCell {
    
    func setupSubviews() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -16),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            newsImageView.heightAnchor.constraint(equalToConstant: 60),
            newsImageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        setupStyle()
    }
    
    func fetchImage(by string: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: string) else {
            completion(nil)
            return
        }
        ImageCache.default.fetchImage(url: url, completion: completion)
    }
}
