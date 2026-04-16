// swift-tools-version: 5.9

import PackageDescription

var package = Package(
   name: "msgpack-swift",
   platforms: [
      .visionOS(.v1),
      .macOS(.v13),
      .macCatalyst(.v16),
      .iOS(.v16),
      .tvOS(.v16),
      .watchOS(.v9),
   ],
   products: [
      .library(
         // TODO: Remove `DM` prefix after FB13180164 is resolved. The Xcode build system fails to build
         // a package graph that has duplicate product names. In this case, the `Flight-School/MessagePack`
         // package also has a product named `MessagePack`.
         name: "DMMessagePack",
         targets: [
            "MessagePack",
         ]
      ),
   ],
   dependencies: [
      .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.3.0"),
   ],
   targets: [
      .target(
         name: "MessagePack"
      ),

      .testTarget(
         name: "MessagePackTests",
         dependencies: [
            "MessagePack",
         ],
      ),
   ]
)

let commonSwiftSettings: [SwiftSetting] = [
   .enableUpcomingFeature("StrictConcurrency"),
]
for index in (package.targets.startIndex)..<package.targets.endIndex {
   let targetSpecificSwiftSettings = package.targets[index].swiftSettings ?? []
   package.targets[index].swiftSettings = targetSpecificSwiftSettings + commonSwiftSettings
}
