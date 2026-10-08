//
//  OnFirstAppearModifier.swift
//  AraxUI
//
//  Created by Achmad Rijalu A on 04/09/26.
//

import SwiftUI

public struct OnFirstAppearModifier: ViewModifier {
    private let onFirstAppearAction: () -> ()
    @State private var hasAppeared: Bool = false
    
    public init(onFirstAppearAction: @escaping () -> Void) {
        self.onFirstAppearAction = onFirstAppearAction
    }
    
    public func body(content: Content) -> some View {
        content.onAppear {
            guard !hasAppeared else { return }
            hasAppeared = true
            onFirstAppearAction()
        }
    }
}
