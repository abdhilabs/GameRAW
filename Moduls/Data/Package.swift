// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Data",
  platforms: [
    .iOS(.v16)
  ],
  products: [
    .library(
      name: "Data",
      targets: ["Data"])
  ],
  dependencies: [
    .package(url: "https://github.com/Moya/Moya.git", .upToNextMajor(from: "15.0.0")),
    .package(url: "https://github.com/tristanhimmelman/ObjectMapper", from: "4.1.0")
  ],
  targets: [
    .target(
      name: "Data",
      dependencies: [
        .product(name: "CombineMoya", package: "Moya"),
        .product(name: "ObjectMapper", package: "ObjectMapper")
      ])
  ]
)
