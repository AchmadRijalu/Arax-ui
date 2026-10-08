//
//  GeneralTextField.swift
//  Arax
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import Foundation
import SwiftUI
import Combine

private let kInputHeight: CGFloat = 52.0
typealias AraxImageHandler = (image: UIImage, didTap: (() -> Void)?)

struct AraxTextField: View {
    @Binding var currentTypedText: String
    
    private let shouldInterceptFocus: Bool
    private let leadingIcon: UIImage?
    private let trailingIcon: AraxImageHandler?
    private let placeholder: String?
    
    @FocusState private var isFocused: Bool
    private let onFocusedAction: ((Bool) -> Void)?
    
    init(
        leadingIcon: UIImage? = nil,
        currentTypedText: Binding<String>,
        trailingIcon: AraxImageHandler? = nil,
        placeholder: String?,
        shouldInterceptFocus: Bool = false,
        onFocusedAction: ((Bool) -> Void)? = nil
    ) {
        self.leadingIcon = leadingIcon
        _currentTypedText = currentTypedText
        self.trailingIcon = trailingIcon
        self.placeholder = placeholder
        self.shouldInterceptFocus = shouldInterceptFocus
        self.onFocusedAction = onFocusedAction
    }
    
    var body: some View {
        TextField(
            placeholder ?? "",
            text: $currentTypedText
        )
        .textFieldStyle(
            AraxTextFieldStyle(
                leadingIcon: leadingIcon,
                placeHolder: placeholder,
                trailingIcon: trailingIcon,
                shouldInterceptFocus: shouldInterceptFocus,
                onFocusedAction: onFocusedAction
            )
        )
        .focused($isFocused)
        .onChange(of: isFocused) { isFocused in
            onFocusedAction?(isFocused)
        }
        .frame(height: kInputHeight)
    }
}

struct AraxTextFieldStyle: TextFieldStyle {
    let leadingIcon: UIImage?
    let placeHolder: String?
    let trailingIcon: AraxImageHandler?
    let shouldInterceptFocus: Bool
    let onFocusedAction: ((Bool) -> Void)?
    
    init(
        leadingIcon: UIImage?,
        placeHolder: String?,
        trailingIcon: AraxImageHandler?,
        shouldInterceptFocus: Bool,
        onFocusedAction: ((Bool) -> Void)?
    ) {
        self.leadingIcon = leadingIcon
        self.placeHolder = placeHolder
        self.trailingIcon = trailingIcon
        self.shouldInterceptFocus = shouldInterceptFocus
        self.onFocusedAction = onFocusedAction
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        HStack(alignment: .center, spacing: 8.0) {
            if let leadingIcon: UIImage {
                Image(uiImage: leadingIcon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18.0, height: 18.0)
            }
            
            ZStack(alignment: .leading) {
                configuration
                    .disabled(shouldInterceptFocus)

                if shouldInterceptFocus {
                    Color.clear
                        .contentShape(Rectangle())
                        .onTapGesture {
                            onFocusedAction?(true)
                        }
                }
            }
            .frame(maxWidth: .infinity, minHeight: 24, maxHeight: 24, alignment: .leading)

            Spacer()
                
            if let trailingIcon: AraxImageHandler {
                Rectangle()
                    .frame(width: 1.0, height: 18.0)
                    .foregroundStyle(AraxToken.additionalColorsLine.toColor())
                
                Image(uiImage: trailingIcon.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18.0, height: 18.0)
                    .onTapGesture {
                        trailingIcon.didTap?()
                    }
            }
        }
        .padding(.vertical, 14.0)
        .padding(.horizontal, 16.0)
        .background(AraxToken.mainColorSecondary.toColor())
        .clipShape(Capsule(style: .continuous))
    }
}

final class AraxTextFieldHostingController: UIHostingController<AraxTextField> {
    init(viewModel: AraxTextFieldViewModel) {
        super.init(rootView: AraxTextField(
            leadingIcon: viewModel.leadingIcon,
            currentTypedText: viewModel.binding(\.currentTypedText),
            trailingIcon: viewModel.trailingIcon,
            placeholder: viewModel.placeholderText,
            shouldInterceptFocus: viewModel.shouldInterceptFocus,
            onFocusedAction: viewModel.onTextFieldFocusDidChange(to:)
        ))
        view.backgroundColor = .clear

        if #available(iOS 16.0, *) {
            sizingOptions = [.intrinsicContentSize]
        }
    }

    @MainActor @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
