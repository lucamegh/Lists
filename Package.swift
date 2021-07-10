// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "Lists",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "Lists",
            targets: ["Lists"]
        )
    ],
    targets: [
        .target(
            name: "Lists",
            dependencies: []
        ),
        .testTarget(
            name: "ListsTests",
            dependencies: ["Lists"]
        )
    ]
)
