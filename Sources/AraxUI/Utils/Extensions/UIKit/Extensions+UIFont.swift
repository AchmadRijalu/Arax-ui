//
//  Extensions+UIFont.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 21/10/26.
//


import UIKit
import CoreText

public enum PoppinsWeight: CaseIterable {
    case regular
    case medium
    case semiBold
    case bold

    var fontName: String {
        switch self {
        case .regular:
            return "Poppins-Regular"
        case .medium:
            return "Poppins-Medium"
        case .semiBold:
            return "Poppins-SemiBold"
        case .bold:
            return "Poppins-Bold"
        }
    }
}

public enum AraxFont {
    static let registered: Bool = {
        for weight in PoppinsWeight.allCases {
            guard let url = Bundle.module.url(forResource: weight.fontName, withExtension: "ttf") else { continue }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
        return true
    }()
    
    public static func register() { _ = registered }
}

extension UIFont {
    public static func poppins(_ weight: PoppinsWeight = .regular, size: CGFloat) -> UIFont {
        _ = AraxFont.registered
        return UIFont(name: weight.fontName, size: size) ?? .systemFont(ofSize: size)
    }
}

extension UILabel {
    @discardableResult
    public func poppins(_ weight: PoppinsWeight = .regular, size: CGFloat) -> Self {
        font = .poppins(weight, size: size)
        return self
    }
}
