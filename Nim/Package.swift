// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Nim",
    targets: [
        .executableTarget(
            name: "Nim",
            path: "Sources/Nim"
        )
    ]
)
