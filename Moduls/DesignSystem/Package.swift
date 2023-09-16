// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "DesignSystem",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "DesignSystem",
      targets: ["DesignSystem"])
  ],
  dependencies: [
    .package(url: "https://github.com/kean/Nuke", from: "12.0.0")
  ],
  targets: [
    .target(
      name: "DesignSystem",
      dependencies: [
        .product(name: "NukeUI", package: "Nuke")
      ])
  ]
)
