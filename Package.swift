// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "Shepherd",
    products: [
        .library(name: "Shepherd", type: .dynamic, targets: ["Shepherd"]),
    ],
    dependencies: [
        .package(url: "https://github.com/danger/swift.git", from: "1.0.0"), // dev
        .package(url: "https://github.com/f-meloni/Rocket", from: "0.1.0"), // dev
        .package(url: "https://github.com/Quick/Quick.git", from: "2.0.0"), // dev
        .package(url: "https://github.com/Quick/Nimble.git", from: "8.0.0"), // dev
    ],
    targets: [
        .target(name: "Shepherd", path: "Source"),
        .testTarget(name: "ShepherdTests", dependencies: ["Shepherd", "Quick", "Nimble"], path: "Tests"),
    ]
)
