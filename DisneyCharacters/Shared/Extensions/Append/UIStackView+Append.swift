//
//  UIStackView+Append.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 29/12/24.
//

import UIKit

extension UIStackView {
    @discardableResult
    func appendArrangedSubviews(_ views: [UIView]) -> Self {
        views.forEach { addArrangedSubview($0) }
        return self
    }
    
    @discardableResult
    func appendArrangedSubview(_ view: UIView) -> Self {
        addArrangedSubview(view)
        return self
    }
}
