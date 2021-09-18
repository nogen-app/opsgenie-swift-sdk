// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "opsgenie-swift-sdk",
    products: [
        .library(name: "OpsGenieSDK", targets: ["OpsGenieSDK"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0")
    ],
    targets: [
        .target(
            name: "OpsGenieSDK",
            dependencies: [
                .product(name: "NIOCore", package: "swift-nio"),
            ]
        )
//        .testTarget(
//            name: "opsgenie-swift-sdkTests",
//            dependencies: ["OpsGenieSDK"]),
    ]
)
