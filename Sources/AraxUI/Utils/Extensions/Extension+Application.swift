//
//  Extension+Application.swift
//  Arax
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import UIKit

extension UIApplication {
    public func topViewController(
        base: UIViewController? = UIApplication.shared
            .connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.keyWindow }
            .first?.rootViewController
    ) -> UIViewController? {
        
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        return base
    }
}
