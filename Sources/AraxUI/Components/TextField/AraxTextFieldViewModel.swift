//
//  AraxTextFieldViewModel.swift
//  AraxUI
//
//  Created by Achmad Rijalu A on 08/10/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
public protocol AraxTextFieldViewModelDelegate: AnyObject {
    func notifyAraxTextFieldDidChangeFocus(_ viewModel: AraxTextFieldViewModel, isFocused: Bool)
}

@MainActor
public final class AraxTextFieldViewModel: ObservableObject {
    public weak var delegate: AraxTextFieldViewModelDelegate?

    @Published public var currentTypedText: String

    public let leadingIcon: UIImage?
    public let trailingIcon: AraxImageHandler?
    public let placeholderText: String?
    public let shouldInterceptFocus: Bool

    public init(
        leadingIcon: UIImage? = nil,
        placeholderText: String? = nil,
        currentTypedText: String = "",
        trailingIcon: AraxImageHandler? = nil,
        shouldInterceptFocus: Bool = false,
        delegate: AraxTextFieldViewModelDelegate? = nil
    ) {
        self.leadingIcon = leadingIcon
        self.placeholderText = placeholderText
        self.currentTypedText = currentTypedText
        self.trailingIcon = trailingIcon
        self.shouldInterceptFocus = shouldInterceptFocus
        self.delegate = delegate
    }

    public func onTextFieldFocusDidChange(to newFocus: Bool) {
        delegate?.notifyAraxTextFieldDidChangeFocus(self, isFocused: newFocus)
    }
}
