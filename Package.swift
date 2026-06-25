// swift-tools-version: 6.3.1

import PackageDescription

let package = Package(
    name: "swift-initialization-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "Initialization Primitive",
            targets: ["Initialization Primitive"]
        ),

        // MARK: - Protocol
        .library(
            name: "Initialization Protocol",
            targets: ["Initialization Protocol"]
        ),

        // MARK: - Witness
        .library(
            name: "Initialization Witness Primitives",
            targets: ["Initialization Witness Primitives"]
        ),

        // MARK: - Attachable
        .library(
            name: "Initiable",
            targets: ["Initiable"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Initialization Primitives",
            targets: ["Initialization Primitives"]
        ),

        // MARK: - Standard Library Integration
        .library(
            name: "Initialization Primitives Standard Library Integration",
            targets: ["Initialization Primitives Standard Library Integration"]
        ),

        // MARK: - Test Support
        .library(
            name: "Initialization Primitives Test Support",
            targets: ["Initialization Primitives Test Support"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        // MARK: - Namespace
        .target(
            name: "Initialization Primitive",
            dependencies: []
        ),

        // MARK: - Protocol
        .target(
            name: "Initialization Protocol",
            dependencies: [
                "Initialization Primitive",
            ]
        ),

        // MARK: - Witness
        .target(
            name: "Initialization Witness Primitives",
            dependencies: [
                "Initialization Protocol",
            ]
        ),

        // MARK: - Attachable
        .target(
            name: "Initiable",
            dependencies: [
                "Initialization Witness Primitives",
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Initialization Primitives",
            dependencies: [
                "Initialization Primitive",
                "Initialization Protocol",
                "Initialization Witness Primitives",
                "Initiable",
            ]
        ),

        // MARK: - Standard Library Integration
        .target(
            name: "Initialization Primitives Standard Library Integration",
            dependencies: [
                "Initiable",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Initialization Primitives Test Support",
            dependencies: [
                "Initialization Primitives",
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Initialization Primitives Tests",
            dependencies: [
                "Initialization Primitives",
                "Initialization Primitives Standard Library Integration",
                "Initialization Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
