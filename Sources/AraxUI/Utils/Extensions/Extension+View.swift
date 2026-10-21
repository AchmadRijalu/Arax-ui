//
//  Extension+View.swift
//  Arax
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI
import UIKit

public let araxBaseCornerRadius: CGFloat = 24

/// Top-rounded rectangle for iOS 16, where UnevenRoundedRectangle does not
/// exist yet. UIBezierPath already knows how to round a subset of corners, so
/// there are no arcs to get wrong here.
public struct TopRoundedRectangle: Shape {
    public var radius: CGFloat

    public init(radius: CGFloat = araxBaseCornerRadius) {
        self.radius = radius
    }

    public func path(in rect: CGRect) -> Path {
        Path(
            UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: [.topLeft, .topRight],
                cornerRadii: CGSize(width: radius, height: radius)
            ).cgPath
        )
    }
}

extension View {
    public func baseRoundedCorner() -> some View {
        clipShape(RoundedRectangle(cornerRadius: araxBaseCornerRadius, style: .continuous))
    }

    /// Rounds the top corners only. For containers pinned to the bottom edge —
    /// a sheet, a sticky footer — where rounding the bottom corners would curve
    /// them away from the screen edge and leave a gap.
    ///
    /// iOS 17 draws the continuous curve that matches `baseRoundedCorner()`;
    /// iOS 16 falls back to a circular one, which is the closest it can do.
    @ViewBuilder
    public func baseTopRoundedCorner() -> some View {
        if #available(iOS 17.0, *) {
            clipShape(
                .rect(
                    topLeadingRadius: araxBaseCornerRadius,
                    topTrailingRadius: araxBaseCornerRadius,
                    style: .continuous
                )
            )
        } else {
            clipShape(TopRoundedRectangle())
        }
    }

    public func capsuleRounded() -> some View {
        clipShape(Capsule(style: .continuous))
    }
}
