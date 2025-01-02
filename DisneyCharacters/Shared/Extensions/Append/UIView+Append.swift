//
//  UIView+Append.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import UIKit

extension UIView {
    @discardableResult
    func appendSubview(_ view: UIView) -> Self {
        addSubview(view)
        return self
    }
}
