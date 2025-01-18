// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DynamicSheet",
	platforms: [
		.iOS(.v15)
	],
    products: [
       .library(
            name: "DynamicSheet",
            targets: [
				"DynamicSheet"
			]
	   ),
    ],
    targets: [
       .target(
            name: "DynamicSheet",
			dependencies: ["DynamicSheetDetent"]
	   ),
		.target(
            name: "DynamicSheetDetent",
			dependencies: [],
			publicHeadersPath: "include"
	   ),
	]
)
