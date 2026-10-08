//
//  AraxButton.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI

public struct AraxButton<Content: View>: View {
    private let action: () -> Void
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let borderColor: Color?
    private let borderWidth: CGFloat
    @ViewBuilder private let content: () -> Content

    public init(
        backgroundColor: Color,
        foregroundColor: Color,
        borderColor: Color? = nil,
        borderWidth: CGFloat = 1,
        action: @escaping () -> Void,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.action = action
        self.content = content
    }

    public var body: some View {
        Button(action: action) {
            content()
                .frame(maxWidth: .infinity)
                .foregroundStyle(foregroundColor)
                .frame(height: 56)
                .background(backgroundColor)
                .clipShape(.capsule)
                .overlay {
                    if let borderColor {
                        Capsule()
                            .stroke(borderColor, lineWidth: borderWidth)
                    }
                }
                .padding(.horizontal, 6)
        }
        .buttonStyle(AraxButtonStyle())
    }
}

public struct AraxButtonStyle: ButtonStyle {
    public init() {}

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .opacity(configuration.isPressed ? 0.85: 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

#Preview {
    AraxButton(
        backgroundColor: AraxTheme.current.mainColorPrimary.color,
        foregroundColor: AraxTheme.current.additionalColorsWhite.color,
        action: {}
    ) {
        Text("Button")
    }
}
