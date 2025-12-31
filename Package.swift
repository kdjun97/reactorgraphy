// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings
    import ProjectDescriptionHelpers

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "ReactorGraphy",
    dependencies: [
        .package(url: "https://github.com/Swinject/Swinject.git", from: "2.9.1"),
        .package(url: "https://github.com/ReactorKit/ReactorKit.git", from: "3.2.0"),
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.9.1"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.7.1")
    ]
)
