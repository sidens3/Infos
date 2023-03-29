//
//  Identifiable+Extensions.swift
//  Infos
//
//  Created by Михаил Зиновьев on 29.03.2023.
//

import UIKit

extension Identifiable {
    public static var classIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: Identifiable { }
