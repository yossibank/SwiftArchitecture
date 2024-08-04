// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

// MARK: - Library

let ohHttpStubs = Target.Dependency.product(
    name: "OHHTTPStubsSwift",
    package: "OHHTTPStubs"
)

// MARK: - Macro

let codingKeysMacro = Target.Dependency.product(
    name: "CodingKeys",
    package: "CodingKeysMacro"
)

let structBuilderMacro = Target.Dependency.product(
    name: "StructBuilder",
    package: "StructBuilderMacro"
)

// MARK: - Package

let appIcon = Target.target(
    name: "AppIcon"
)

let appDebug = Target.target(
    name: "AppDebug"
)

let utility = Target.target(
    name: "Utility"
)

let utilityView = Target.target(
    name: "UtilityView",
    dependencies: [utility]
)

let apiClient = Target.target(
    name: "APIClient",
    dependencies: [
        appDebug,
        utility
    ]
)

let appCore = Target.target(
    name: "AppCore",
    dependencies: [
        apiClient,
        utility
    ]
)

let rakuten = Target.target(
    name: "Rakuten",
    dependencies: [
        apiClient,
        appCore,
        utility
    ],
    dependenciesLibraries: [
        codingKeysMacro,
        structBuilderMacro
    ]
)

let rakutenView = Target.target(
    name: "RakutenView",
    dependencies: [
        appCore,
        appDebug,
        rakuten,
        utilityView
    ]
)

// MARK: - Test Package

let apiClientTests = Target.testTarget(
    name: "APIClientTests",
    dependencies: [apiClient],
    dependenciesLibraries: [ohHttpStubs],
    resources: [.process("Json")]
)

let utilityTests = Target.testTarget(
    name: "UtilityTests",
    dependencies: [utility]
)

let rakutenTests = Target.testTarget(
    name: "RakutenTests",
    dependencies: [
        apiClient,
        rakuten
    ]
)

let rakutenViewTests = Target.testTarget(
    name: "RakutenViewTests",
    dependencies: [rakutenView]
)

// MARK: - Target

let package = Package.package(
    name: "Package",
    platforms: [
        .iOS(.v17)
    ],
    dependencies: [
        .package(
            url: "https://github.com/nicklockwood/SwiftFormat",
            from: "0.54.3"
        ),
        .package(
            url: "https://github.com/AliSoftware/OHHTTPStubs",
            from: "9.1.0"
        ),
        .package(
            url: "https://github.com/yossibank/CodingKeysMacro",
            from: "1.0.0"
        ),
        .package(
            url: "https://github.com/yossibank/StructBuilderMacro",
            from: "1.0.0"
        )
    ],
    targets: [
        apiClient,
        appCore,
        appDebug,
        appIcon,
        rakuten,
        rakutenView,
        utility,
        utilityView
    ],
    testTargets: [
        apiClientTests,
        rakutenTests,
        rakutenViewTests,
        utilityTests
    ]
)

// MARK: - Extension

extension Target {
    private var dependency: Target.Dependency {
        .target(
            name: name,
            condition: nil
        )
    }

    fileprivate func library(targets: [Target] = []) -> Product {
        .library(
            name: name,
            targets: [name] + targets.map(\.name)
        )
    }

    static func target(
        name: String,
        dependencies: [Target] = [],
        dependenciesLibraries: [Target.Dependency] = [],
        resources: [Resource] = [],
        swiftSettings: [SwiftSetting] = SwiftSetting.allCases
    ) -> Target {
        .target(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            resources: resources,
            swiftSettings: swiftSettings
        )
    }

    static func testTarget(
        name: String,
        dependencies: [Target],
        dependenciesLibraries: [Target.Dependency] = [],
        resources: [Resource] = [],
        swiftSettings: [SwiftSetting] = SwiftSetting.allCases
    ) -> Target {
        .testTarget(
            name: name,
            dependencies: dependencies.map(\.dependency) + dependenciesLibraries,
            resources: resources,
            swiftSettings: swiftSettings
        )
    }
}

extension Package {
    static func package(
        name: String,
        defaultLocalization: LanguageTag = "ja",
        platforms: [SupportedPlatform],
        dependencies: [Dependency] = [],
        targets: [Target],
        testTargets: [Target]
    ) -> Package {
        .init(
            name: name,
            defaultLocalization: defaultLocalization,
            platforms: platforms,
            products: targets.map { $0.library() },
            dependencies: dependencies,
            targets: targets + testTargets
        )
    }
}

// MARK: - Swift Upcoming Feature Flags

extension SwiftSetting {
    /// Forward-scan matching for trailing closures
    /// - Version: Swift 5.3
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0286-forward-scan-trailing-closures.md
    static let forwardTrailingClosures: Self = .enableUpcomingFeature("ForwardTrailingClosures")
    /// Introduce existential `any`
    /// - Version: Swift 5.6
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0335-existential-any.md
    static let existentialAny: Self = .enableUpcomingFeature("ExistentialAny")
    /// Regex Literals
    /// - Version: Swift 5.7
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0354-regex-literals.md
    static let bareSlashRegexLiterals: Self = .enableUpcomingFeature("BareSlashRegexLiterals")
    /// Concise magic file names
    /// - Version: Swift 5.8
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0274-magic-file.md
    static let conciseMagicFile: Self = .enableUpcomingFeature("ConciseMagicFile")
    /// Importing Forward Declared Objective-C Interfaces and Protocols
    /// - Version: Swift 5.9
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0384-importing-forward-declared-objc-interfaces-and-protocols.md
    static let importObjcForwardDeclarations: Self = .enableUpcomingFeature("ImportObjcForwardDeclarations")
    /// Remove Actor Isolation Inference caused by Property Wrappers
    /// - Version: Swift 5.9
    /// https://github.com/apple/swift-evolution/blob/main/proposals/0401-remove-property-wrapper-isolation.md
    static let disableOutwardActorInference: Self = .enableUpcomingFeature("DisableOutwardActorInference")
    /// Deprecate `@UIApplicationMain` and `@NSApplicationMain`
    /// - Version: Swift 5.10
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0383-deprecate-uiapplicationmain-and-nsapplicationmain.md
    static let deprecateApplicationMain: Self = .enableUpcomingFeature("DeprecateApplicationMain")
    /// Isolated default value expressions
    /// - Version: Swift 5.10
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0411-isolated-default-values.md
    static let isolatedDefaultValues: Self = .enableUpcomingFeature("IsolatedDefaultValues")
    /// Strict concurrency for global variables
    /// - Version: Swift 5.10
    /// - https://github.com/apple/swift-evolution/blob/main/proposals/0412-strict-concurrency-for-global-variables.md
    static let globalConcurrency: Self = .enableUpcomingFeature("GlobalConcurrency")
}

extension SwiftSetting: CaseIterable {
    public static var allCases: [Self] {
        [
            .forwardTrailingClosures,
            .existentialAny,
            .bareSlashRegexLiterals,
            .conciseMagicFile,
            .importObjcForwardDeclarations,
            .disableOutwardActorInference,
            .deprecateApplicationMain,
            .isolatedDefaultValues,
            .globalConcurrency
        ]
    }
}
