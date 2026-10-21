//
//  Extension+View.swift
//  Arax
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI

public let araxBaseCornerRadius: CGFloat = 24

extension View {
    public func baseRoundedCorner() -> some View {
        clipShape(RoundedRectangle(cornerRadius: araxBaseCornerRadius, style: .continuous))
    }

    /// Rounds the top corners only. For containers pinned to the bottom edge —
    /// a sheet, a sticky footer — where rounding the bottom corners would curve
    /// them away from the screen edge and leave a gap.
    public func baseTopRoundedCorner() -> some View {
        clipShape(
            .rect(
                topLeadingRadius: araxBaseCornerRadius,
                topTrailingRadius: araxBaseCornerRadius,
                style: .continuous
            )
        )
    }

    public func capsuleRounded() -> some View {
        clipShape(Capsule(style: .continuous))
    }
}
