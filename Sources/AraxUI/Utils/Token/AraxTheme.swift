//
//  AraxTheme.swift
//  AraxUI
//
//  Created by Achmad Rijalu  A on 08/10/26.
//

import UIKit

/// The design tokens every AraxUI component reads from.
///
/// Apps override only what they need, once, at launch:
///
///     AraxTheme.current.mainColorPrimary = AraxColor("#FF5A1F")
///
public struct AraxTheme {
    nonisolated(unsafe) public static var current = AraxTheme()

    // MARK: Main

    public var mainColorPrimary = AraxColor("#1AB2E5")
    public var mainColorSecondary = AraxColor(light: "#F6F8FE", dark: "#1A1A1A")
    public var mainColorDarkGray = AraxColor(light: "#2F3C33", dark: "#E3E9ED")
    public var mainColorLemon = AraxColor("#B9EC63")
    public var mainColorForth = AraxColor(light: "#F6F5F6", dark: "#222222")

    // MARK: Alerts
    public var alertsSuccess = AraxColor("#00C566")
    public var alertsError = AraxColor(light: "#E53935", dark: "#FF6B6B")
    public var alertsWarning = AraxColor(light: "#FACC15", dark: "#FFD93B")

    // MARK: Additional
    public var additionalColorsWhite = AraxColor(light: "#FEFEFE", dark: "#121212")
    public var additionalColorsLine = AraxColor(light: "#E3E7EC", dark: "#2A2D31")
    public var additionalColorsLineDark = AraxColor(light: "#282837", dark: "#E3E7EC")
    public var additionalColorsBlack = AraxColor(light: "#111111", dark: "#FFFFFF")
    public var additionalColorsPurple = AraxColor(light: "#936DFF", dark: "#BDA7FF")
    public var additionalColorsOrange = AraxColor(light: "#FF784B", dark: "#FF9E7A")

    // MARK: Grayscale
    public var grayscale10 = AraxColor(light: "#E3E9ED", dark: "#1C1C1C")
    public var grayscale20 = AraxColor(light: "#ECF1F6", dark: "#2A2A2A")
    public var grayscale30 = AraxColor(light: "#E3E9ED", dark: "#333333")
    public var grayscale40 = AraxColor(light: "#D1D8DD", dark: "#444444")
    public var grayscale50 = AraxColor(light: "#BFC6CC", dark: "#555555")
    public var grayscale60 = AraxColor(light: "#9CA4AB", dark: "#777777")
    public var grayscale70 = AraxColor(light: "#78828A", dark: "#AAAAAA")
    public var grayscale80 = AraxColor(light: "#66707A", dark: "#CCCCCC")
    public var grayscale90 = AraxColor(light: "#434E58", dark: "#DDDDDD")
    public var grayscale100 = AraxColor(light: "#171725", dark: "#F5F5F5")

    public init() {}
}
