//
//  Extensions+Font.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 21/10/26.
//

import SwiftUI

extension Font {
    public static func poppins(_ weight: PoppinsWeight = .regular, size: CGFloat) -> Font {
        _ = AraxFont.registered
        return .custom(weight.fontName, size: size)
    }
}
