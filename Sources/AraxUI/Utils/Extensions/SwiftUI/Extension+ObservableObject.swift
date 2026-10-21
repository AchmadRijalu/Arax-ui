//
//  Extension+ObservableObject.swift
//  AraxUI
//
//  Created by Achmad Rijalu - Intikom on 19/06/26.
//

import Combine
import SwiftUI

extension ObservableObject {
    public func binding<Value>(_ keyPath: ReferenceWritableKeyPath<Self, Value>) -> Binding<Value> {
        Binding(
            get: { self[keyPath: keyPath] },
            set: { self[keyPath: keyPath] = $0 }
        )
    }
}
