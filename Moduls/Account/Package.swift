// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Account",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Account",
      targets: ["Account"])
  ],
  dependencies: [
    .package(name: "Common", path: "../Common"),
    .package(name: "DesignSystem", path: "../DesignSystem")
  ],
  targets: [
    .target(
      name: "Account",
      dependencies: [
        .product(name: "Common", package: "Common"),
        .product(name: "DesignSystem", package: "DesignSystem")
      ])
  ]
)
