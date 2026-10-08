//
//  AraxBottomSheetTests.swift
//  AraxUITests
//

import XCTest
@testable import AraxUI

@MainActor
final class AraxBottomSheetTests: XCTestCase {

    /// `init` used to call `setupView()`, and reading `view` inside it triggered
    /// `viewDidLoad`, which called `setupView()` again. `addSubview` only moves
    /// an existing subview, so the hierarchy stayed correct — but
    /// `NSLayoutConstraint.activate` ran twice and left 12 constraints
    /// installed instead of 6.
    func testSetupViewRunsOnce() {
        let sheet = AraxBottomSheet(image: nil, title: "Title", message: "Message")

        sheet.loadViewIfNeeded()

        XCTAssertEqual(sheet.view.constraints.count, 6,
                       "4 for dismissButton + 4 for verticalStackView, minus the 2 UIKit folds away")
        XCTAssertEqual(sheet.view.subviews.count, 2)
        XCTAssertEqual(sheet.verticalStackView.arrangedSubviews.count, 3)
    }

    func testInitConfiguresSubviews() {
        let image = UIImage(systemName: "checkmark")
        let sheet = AraxBottomSheet(image: image, title: "Title", message: "Message")

        sheet.loadViewIfNeeded()

        XCTAssertEqual(sheet.titleLabel.text, "Title")
        XCTAssertEqual(sheet.messageLabel.text, "Message")
        XCTAssertIdentical(sheet.imageView.image, image)
    }
}
