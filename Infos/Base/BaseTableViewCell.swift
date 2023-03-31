//
//  BaseTableViewCell.swift
//  Infos
//
//  Created by Михаил Зиновьев on 31.03.2023.
//

import UIKit

class BaseTableViewCell: UITableViewCell {}

// MARK: - Style
extension BaseTableViewCell {
    
    func setupStyle() {
        contentView.backgroundColor = .clear
        backgroundColor = .systemBackground
        selectionStyle = .none
    }
}
