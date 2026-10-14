//
//  Extension+UIViewController.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 14/10/26.
//

import UIKit

extension UIViewController {
    public func embedViewToViewController(_ hosting: UIViewController, in container: UIView) {
        container.clipsToBounds = true
        
        addChild(hosting)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.backgroundColor = .clear
        hosting.view.setContentHuggingPriority(.required, for: .vertical)
        hosting.view.setContentCompressionResistancePriority(.required, for: .vertical)
        container.addSubview(hosting.view)
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: container.topAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        hosting.didMove(toParent: self)
    }
}
