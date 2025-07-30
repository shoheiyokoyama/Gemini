
// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Gemini",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Gemini",
            targets: ["Gemini"]
        ),
    ],
    dependencies: [
        // Add your dependencies here, if any
    ],
    targets: [
        .target(
            name: "Gemini",
            dependencies: [],
            path: "Sources/Gemini"
        ),
    ]
)

