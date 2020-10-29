// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "IResult",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "IResult",
            targets: ["IResult"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "IResult",
            dependencies: [])
    ])
