// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "PactConsumerSwift",
  platforms: [
    .macOS(.v10_10), .iOS(.v8), .tvOS(.v9)
  ],
  products: [
    .library(name: "PactConsumerSwift", targets: ["PactConsumerSwift"])
  ],
  targets: [
    .target(
      name: "PactConsumerSwift",
      dependencies: [],
      path: "./Sources"
    )
  ]
)
