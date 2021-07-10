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
    dependencies: [
        .package(url: "https://github.com/lucamegh/ReusableView", .exact("1.0.0"))
    ],
    targets: [
        .target(
            name: "Lists",
            dependencies: [
                "ReusableView"
            ]
        ),
        .testTarget(
            name: "ListsTests",
            dependencies: ["Lists"]
        )
    ]
)
