// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "ShepherdDevelopmentDependencies",
    platforms: [
        .macOS(.v10_10),
    ],
    products: [
        .library(name: "DangerDeps", type: .dynamic, targets: ["DangerDependencies"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", from: "2.0.0"),
        .package(url: "https://github.com/JosephDuffy/SwiftChecksDangerPlugin.git", from: "0.1.0"),
        .package(url: "https://github.com/Realm/SwiftLint", .upToNextMinor(from: "0.36.0")),
    ],
    targets: [
        .target(name: "DangerDependencies", dependencies: ["Danger", "swiftlint", "danger-swift", "SwiftChecksDangerPlugin"], path: "DangerDependencies"), // dev
    ]
)
