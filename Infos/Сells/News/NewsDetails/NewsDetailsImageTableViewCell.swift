//
//  NewsDetailsImageTableViewCell.swift
//  Infos
//
//  Created by Михаил Зиновьев on 01.04.2023.
//

import UIKit
import Kingfisher

class NewsDetailsImageTableViewCell: BaseTableViewCell {

    // MARK: - UI elements
    private var newsImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "arrow.triangle.2.circlepath.camera")
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(urlToImage: String) {
        setupSubviews()
        fetchImage(by: urlToImage) { [weak self] image in
            self?.newsImageView.image = image
        }
    }
}

// MARK: - Override
extension NewsDetailsImageTableViewCell {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        newsImageView.image = UIImage()
    }
}

// MARK: - Private
private extension NewsDetailsImageTableViewCell {
    
    func setupSubviews() {
        contentView.addSubview(newsImageView)

        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            newsImageView.heightAnchor.constraint(equalToConstant: 120),
            newsImageView.widthAnchor.constraint(equalToConstant: 120)
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

