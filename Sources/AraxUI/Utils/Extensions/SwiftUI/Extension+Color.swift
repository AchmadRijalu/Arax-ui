//
//  Extension+Color.swift
//  Arax
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI

extension Color {
    public init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)

        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255,
                            (int >> 8) * 17,
                            (int >> 4 & 0xF) * 17,
                            (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255,
                            int >> 16,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24,
                            int >> 16 & 0xFF,
                            int >> 8 & 0xFF,
                            int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(.sRGB,
                  red: Double(r) / 255,
                  green: Double(g) / 255,
                  blue: Double(b) / 255,
                  opacity: Double(a) / 255)
    }
    
    public static let primaryGreenColor = Color(hex: "03C4A1")
    public static let primaryBlackColor = Color(hex: "050713")
    public static let primaryWhiteColor = Color(hex: "F1F0F2")
}

public enum GradientAxis {
    case vertical
    case horizontal
}

extension LinearGradient {
    public static func vertical(_ stops: (Color, CGFloat)...) -> LinearGradient {
        gradient(axis: .vertical, stops: stops)
    }

    public static func horizontal(_ stops: (Color, CGFloat)...) -> LinearGradient {
        gradient(axis: .horizontal, stops: stops)
    }

    public static func gradient(
        axis: GradientAxis,
        stops: [(Color, CGFloat)]
    ) -> LinearGradient {
        let (startPoint, endPoint) = switch axis {
        case .vertical:
            (UnitPoint.top, UnitPoint.bottom)
        case .horizontal:
            (UnitPoint.leading, UnitPoint.trailing)
        }

        return LinearGradient(
            stops: makeStops(from: stops),
            startPoint: startPoint,
            endPoint: endPoint
        )
    }

    public static func makeStops(from stops: [(Color, CGFloat)]) -> [Gradient.Stop] {
        let total = stops.reduce(0) { $0 + $1.1 }
        guard total > 0 else { return [] }

        var gradientStops: [Gradient.Stop] = []
        var cumulative: CGFloat = 0

        for (color, percent) in stops {
            let start = cumulative / total
            cumulative += percent
            let end = cumulative / total

            gradientStops.append(.init(color: color, location: start))
            gradientStops.append(.init(color: color, location: end))
        }

        return gradientStops
    }
}
