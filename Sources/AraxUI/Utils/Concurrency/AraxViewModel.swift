//
//  AraxViewModel.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 22/09/26.
//

import Combine
import SwiftUI

@MainActor
public protocol AraxViewModel: AnyObject, ObservableObject {
    associatedtype Value
    var state: AraxLoadState<Value> { get set }
}

extension AraxViewModel {
    public var isLoading: Bool { state.isLoading }

    public func resetState() {
        state = .idle
    }
}
