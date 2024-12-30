//
//  CustomViewController.swift
//  DisneyCharacters
//
//  Created by Gustavo Kumasawa on 30/12/24.
//

import UIKit

class CustomViewController: UIViewController {
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.layer.zPosition = 1000
        activityIndicator.startAnimating()
        activityIndicator.alpha = 0
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
}

// MARK: - Loading
extension CustomViewController {
    func showScreenLoading(isUserInteractionEnabled: Bool = false) {
        DispatchQueue.main.async { [self] in
            view.isUserInteractionEnabled = isUserInteractionEnabled
            
            view.appendSubview(activityIndicator)
            
            NSLayoutConstraint.activate([
                activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
            
            UIView.animate(withDuration: 0.3) {
                self.activityIndicator.alpha = 1
            }
        }
    }
    
    func hideScreenLoading() {
        DispatchQueue.main.async { [self] in
            view.isUserInteractionEnabled = true
            
            UIView.animate(withDuration: 0.3) {
                self.activityIndicator.alpha = 0
            } completion: { _ in
                self.activityIndicator.removeFromSuperview()
            }
        }
    }
}
