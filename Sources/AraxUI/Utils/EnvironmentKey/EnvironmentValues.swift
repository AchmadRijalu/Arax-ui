//
//  EnvironmentValues.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import Foundation
import SwiftUI

extension EnvironmentValues {
    public var isStretch: Bool {
        get { self[StretchKey.self]}
        set {self[StretchKey.self] = newValue}
    }
}

public struct StretchKey: EnvironmentKey {
    public static let defaultValue: Bool = false
}

extension AraxButton {
    public func stretch() -> some View {
        self.environment(\.isStretch, true)
    }
}
