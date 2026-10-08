// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AraxUI",
    platforms: [.iOS(.v13)],
    products: [.library(name: "AraxUI", targets: ["AraxUI"])],
    targets: [
        .target(name: "AraxUI")
    ]
)
