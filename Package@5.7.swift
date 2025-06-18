// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

//let platforms: [PackageDescription.Platform] = [.linux]
let platforms: [PackageDescription.Platform] = [.linux]
let swiftSettings: [SwiftSetting] = [.define("COMBINE_LINUX", .when(platforms: platforms))]
let cxxSettings: [CXXSetting] = [.define("COMBINE_LINUX", .when(platforms: platforms))]

let package = Package(
    name: "async-system",
    platforms: [.macOS(.v10_15), .iOS(.v13), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AsyncSystem",
            targets: ["AsyncSystem"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.5.2"),
        .package(url: "https://github.com/0xfeedface1993/CombineX.git", from: "0.4.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AsyncSystem",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                .product(name: "CombineX", package: "CombineX", condition: .when(platforms: platforms))
            ],
            path: "Sources/async-system",
            cxxSettings: cxxSettings,
            swiftSettings: swiftSettings
        ),
        .testTarget(
            name: "AsyncSystemTests",
            dependencies: ["AsyncSystem"],
            cxxSettings: cxxSettings,
            swiftSettings: swiftSettings
        ),
    ]
)
