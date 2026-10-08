//
//  AraxButton.swift
//  Arax
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI

struct AraxButton<Content: View>: View {
    var action: (() -> Void)
    @ViewBuilder var content: () -> Content
    var backgroundColor: Color
    var foregroundColor: Color
    var borderColor: Color? = nil
    var borderWidth: CGFloat = 1
    
    var body: some View {
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

struct AraxButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .opacity(configuration.isPressed ? 0.85: 1)
            .animation(.spring(response: 0.2, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

#Preview {
    AraxButton(action: {
        
    }, content: {
        Text("Button")
    }, backgroundColor: .blue, foregroundColor: .white)
}
