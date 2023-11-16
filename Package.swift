// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MVPlayer",
    platforms: [.iOS(.v15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MVPlayer",
            targets: ["MVPlayer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/wxxsw/VideoPlayer/", from: "1.2.4"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MVPlayer",
            dependencies: ["VideoPlayer"],
            path: "Sources"
//            resources: [.process("Media")]
        ),
        .testTarget(
            name: "MVPlayerTests",
            dependencies: ["MVPlayer"]
        ),
    ]
)

//
//let package = Package(
//    name: "VideoPlayer",
//    platforms: [.iOS(.v13)],
//    products: [
//        .library(
//            name: "VideoPlayer",
//            targets: ["VideoPlayer"]
//        ),
//    ],
//    dependencies: [
//        .package(url: "https://github.com/wxxsw/GSPlayer.git", from: "0.2.27"),
//    ],
//    targets: [
//        .target(
//            name: "VideoPlayer",
//            dependencies: ["GSPlayer"],
//            path: "Sources"
//        ),
//    ]
//)
