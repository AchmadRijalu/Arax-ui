//
//  AraxToolbar.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import SwiftUI

public struct AraxToolbar: View {
    private let title: String
    private let foregroundColor: Color
    private let backgroundColor: Color
    private let action: () -> Void

    public init(
        title: String,
        foregroundColor: Color? = nil,
        backgroundColor: Color? = nil,
        action: @escaping () -> Void = {}
    ) {
        self.title = title
        self.foregroundColor = foregroundColor ?? AraxTheme.current.additionalColorsBlack.color
        self.backgroundColor = backgroundColor ?? AraxTheme.current.mainColorSecondary.color
        self.action = action
    }

    public var body: some View {
        ZStack {
            HStack {
                Button(action: action) {
                    Image(systemName: "chevron.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(AraxTheme.current.mainColorPrimary.color)
                }
                Spacer()
            }
            Text(title)
                .foregroundStyle(foregroundColor)
                .font(.system(size: 17, weight: .semibold))
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: 55)
        .background(backgroundColor)
    }
}

#Preview {
    AraxToolbar(title: "Title")
}
