//
//  GeneralTextFieldViewModel.swift
//  Arax
//
//  Created by Achmad Rijalu A on 08/10/26.
//

import Foundation
import SwiftUI
import Combine

protocol AraxTextFieldViewModelDelegate: AnyObject {
    func notifyAraxTextFieldDidChangeFocus(_ viewModel: AraxTextFieldViewModel, isFocused: Bool)
}

final class AraxTextFieldViewModel: ObservableObject {
    weak var delegate: AraxTextFieldViewModelDelegate?

    @Published var currentTypedText: String

    let leadingIcon: UIImage?
    let trailingIcon: AraxImageHandler?
    let placeholderText: String?
    let shouldInterceptFocus: Bool

    init(
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

    func onTextFieldFocusDidChange(to newFocus: Bool) {
        delegate?.notifyAraxTextFieldDidChangeFocus(self, isFocused: newFocus)
    }
}
