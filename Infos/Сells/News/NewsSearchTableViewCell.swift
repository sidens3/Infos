//
//  NewsSearchTableViewCell.swift
//  Infos
//
//  Created by Михаил Зиновьев on 31.03.2023.
//

import UIKit

protocol NewsSearchDelegate {
    func makeSearch(for text: String)
}

class NewsSearchTableViewCell: BaseTableViewCell {

    // MARK: - UI elements
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Ваш запрос"
        searchBar.searchBarStyle = .minimal
        searchBar.tintColor = .systemGray
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    var delegate: NewsSearchDelegate?
    
    func configure(delegate: NewsSearchDelegate?) {
        setupSubviews()
        
        self.delegate = delegate
    }
}

// MARK: - Actions
extension NewsSearchTableViewCell {
    
    @objc
    func makeSearch() {
        delegate?.makeSearch(for: "Apple")
    }
}

// MARK: UISearchBarDelegate
extension NewsSearchTableViewCell: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.makeSearch(for: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - Private
private extension NewsSearchTableViewCell {
    
    func setupSubviews() {
        contentView.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: contentView.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            searchBar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            searchBar.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        searchBar.delegate = self
        
        setupStyle()
    }
}
