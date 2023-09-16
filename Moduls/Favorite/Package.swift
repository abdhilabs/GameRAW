// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Favorite",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Favorite",
      targets: ["Favorite"])
  ],
  dependencies: [
    .package(name: "Common", path: "../Common"),
    .package(name: "DesignSystem", path: "../DesignSystem"),
    .package(name: "Domain", path: "../Domain"),
    .package(url: "https://github.com/Tiny-Home-Consulting/Dependiject", .upToNextMajor(from: "1.0.0"))
  ],
  targets: [
    .target(
      name: "Favorite",
      dependencies: [
        .product(name: "Common", package: "Common"),
        .product(name: "DesignSystem", package: "DesignSystem"),
        .product(name: "Domain", package: "Domain"),
        .product(name: "Dependiject", package: "Dependiject")
      ])
  ]
)
