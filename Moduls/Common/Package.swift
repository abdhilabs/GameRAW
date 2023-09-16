// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Common",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Common",
      targets: ["Common"])
  ],
  dependencies: [
     .package(url: "https://github.com/abdhilabs/Fortils", branch: "master")
  ],
  targets: [
    .target(
      name: "Common",
      dependencies: [
        .product(name: "Fortils", package: "Fortils")
      ])
  ]
)
