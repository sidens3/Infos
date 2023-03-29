//
//  UITableView+Extensions.swift
//  Infos
//
//  Created by Михаил Зиновьев on 29.03.2023.
//

import UIKit

extension UITableView {
    
    public func registerClass<T: UITableViewCell>(forCell type: T.Type) {
        register(T.self, forCellReuseIdentifier: T.classIdentifier)
    }
    
    public func dequeue<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.classIdentifier, for: indexPath) as? T else {
            return T(style: .default, reuseIdentifier: T.classIdentifier)
        }
        cell.frame = CGRect(x: 0.0, y: 0.0, width: bounds.width, height: bounds.height)
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
}
