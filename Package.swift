// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.
// https://github.com/apple/swift-package-manager/blob/master/Documentation/PackageDescription.md

import PackageDescription

let package = Package(
    name: "SimulatorKeychain",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        .executable(
            name: "simkey",
            targets: ["simkey"]),
        .library(
            name: "SimulatorKeychainKit",
            type: .dynamic,
            targets: ["SimulatorKeychainKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .upToNextMajor(from: "0.12.2")),
        .package(url: "https://github.com/apple/swift-argument-parser", .upToNextMajor(from: "0.3.1")),
        .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "9.0.0")),
    ],
    targets: [
        .target(
            name: "simkey",
            dependencies: ["SimulatorKeychainKit"]),
        .target(
            name: "SimulatorKeychainKit",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
        .testTarget(
            name: "SimulatorKeychainKitTests",
            dependencies: ["SimulatorKeychainKit", "Quick", "Nimble"]),
    ],
    swiftLanguageVersions: [.v5]
)
