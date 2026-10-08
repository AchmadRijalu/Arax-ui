//
//  ViewControllerPreview.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 08/10/26.
//


import UIKit

#if DEBUG
import SwiftUI

public struct ViewControllerPreview: UIViewControllerRepresentable {
    public let builder: () -> UIViewController

    public init(_ builder: @escaping () -> UIViewController) {
        self.builder = builder
    }

    public func makeUIViewController(context: Context) -> UIViewController { builder() }
    public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

public struct ViewPreview: UIViewRepresentable {
    public let builder: () -> UIView

    public init(_ builder: @escaping () -> UIView) {
        self.builder = builder
    }

    public func makeUIView(context: Context) -> UIView { builder() }
    public func updateUIView(_ uiView: UIView, context: Context) {}
}
#endif
