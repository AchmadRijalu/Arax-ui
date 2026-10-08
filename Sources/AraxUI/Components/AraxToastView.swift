//
//  AraxToastView.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI

struct ToastView<Content: View>: View {

    private let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .font(.subheadline.weight(.medium))
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(.regularMaterial, in: .capsule)
            .shadow(radius: 8, y: 4)
    }
}

extension ToastView where Content == Label<Text, Image> {
    init(_ message: String, systemImage: String = "checkmark.circle.fill") {
        self.init { Label(message, systemImage: systemImage) }
    }
}

extension View {

    func toast<Content: View>(
        isPresented: Binding<Bool>,
        duration: Duration = .seconds(2),
        onDismiss: @escaping () -> Void = {},
        @ViewBuilder content: () -> Content
    ) -> some View {
        let toast = content()

        return overlay(alignment: .top) {
            if isPresented.wrappedValue {
                toast
                    .padding(.top, 8)
                    .transition(.move(edge: .top).combined(with: .opacity))
                    .task {
                        // Cancelled when the toast leaves the hierarchy, which
                        // also means nobody is waiting on onDismiss anymore.
                        guard (try? await Task.sleep(for: duration)) != nil else { return }
                        isPresented.wrappedValue = false
                        onDismiss()
                    }
            }
        }
        .animation(.spring(duration: 0.3), value: isPresented.wrappedValue)
    }
}
