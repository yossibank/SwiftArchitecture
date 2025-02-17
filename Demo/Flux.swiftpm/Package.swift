// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import AppleProductTypes
import PackageDescription

let package = Package(
    name: "Flux",
    platforms: [
        .iOS("17.0")
    ],
    products: [
        .iOSApplication(
            name: "Flux",
            targets: ["Flux"],
            bundleIdentifier: "sample.yossibank-yahoo.co.jp.Flux",
            teamIdentifier: "6WHPY5MQSB",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .weights),
            accentColor: .presetColor(.green),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ]
        )
    ],
    dependencies: [
        .package(path: "../../Package")
    ],
    targets: [
        .executableTarget(
            name: "Flux",
            dependencies: [
                .product(name: "AppDebug", package: "Package", condition: nil),
                .product(name: "Rakuten", package: "Package", condition: nil),
                .product(name: "Utility", package: "Package", condition: nil),
                .product(name: "UtilityView", package: "Package", condition: nil)
            ],
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
