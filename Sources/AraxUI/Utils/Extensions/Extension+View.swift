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

    public func capsuleRounded() -> some View {
        clipShape(Capsule(style: .continuous))
    }
}
