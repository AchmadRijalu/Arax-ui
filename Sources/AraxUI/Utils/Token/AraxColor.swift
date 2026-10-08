//
//  AraxColor.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI
import UIKit

/// A single design-system color, with its light and dark appearance.
public struct AraxColor {
    public let light: UIColor
    public let dark: UIColor

    public init(light: UIColor, dark: UIColor) {
        self.light = light
        self.dark = dark
    }

    public init(_ color: UIColor) {
        self.init(light: color, dark: color)
    }

    public init(light: String, dark: String) {
        self.init(light: .from(light), dark: .from(dark))
    }

    public init(_ hex: String) {
        self.init(light: .from(hex), dark: .from(hex))
    }
    
    public var uiColor: UIColor {
        UIColor { $0.userInterfaceStyle == .dark ? self.dark : self.light }
    }

    public var color: Color { Color(uiColor) }
}

#Preview("Palette") {
    let swatches: [(String, AraxColor)] = [
        ("mainColorPrimary", AraxTheme.current.mainColorPrimary),
        ("mainColorSecondary", AraxTheme.current.mainColorSecondary),
        ("alertsError", AraxTheme.current.alertsError),
        ("additionalColorsBlack", AraxTheme.current.additionalColorsBlack),
        ("grayscale50", AraxTheme.current.grayscale50)
    ]

    return ForEach([ColorScheme.light, .dark], id: \.self) { scheme in
        VStack(alignment: .leading) {
            ForEach(swatches, id: \.0) { name, token in
                HStack {
                    token.color
                        .frame(width: 44, height: 28)
                        .clipShape(.rect(cornerRadius: 6))
                    Text(name).font(.caption)
                }
            }
        }
        .padding()
        .environment(\.colorScheme, scheme)
    }
}
