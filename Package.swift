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
        // MARK: - Attachable
        .library(
            name: "Initialization Primitives",
            targets: ["Initialization Primitives"]
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
        // MARK: - Attachable
        .target(
            name: "Initialization Primitives",
            dependencies: []
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
