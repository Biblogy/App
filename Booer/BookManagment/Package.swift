// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BookManagment",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "BookManagment",
            targets: ["BookManagment"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "0.34.0")),
        .package(url: "./DatabaseBooer", from: "1.0.0"),
        .package(url: "./BooerKit", from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "BookManagment",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                "DatabaseBooer",
                "BooerKit"
            ]),
        .testTarget(
            name: "BookManagmentTests",
            dependencies: ["BookManagment", "DatabaseBooer", "BooerKit"]),
    ]
)
