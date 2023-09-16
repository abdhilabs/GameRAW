// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Domain",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Domain",
      targets: ["Domain"])
  ],
  dependencies: [
    .package(name: "Data", path: "../Data")
  ],
  targets: [
    .target(
      name: "Domain",
      dependencies: [
        .product(name: "Data", package: "Data")
      ])
  ]
)
