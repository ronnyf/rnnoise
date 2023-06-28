// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rnnoise",
    products: [
        .library(
            name: "librnnoise",
            targets: ["rnnoise"]
		),
		.library(
			name: "dylibrnnoise",
			type: .dynamic,
			targets: ["rnnoise"]
		),
		.library(
			name: "librnn_vad",
			type: .static,
			targets: ["rnn_vad"]
		),
		.library(
			name: "dylibrnn_vad",
			type: .dynamic,
			targets: ["rnn_vad"]
		),
    ],
    targets: [
		.target(
			name: "rnn_vad",
			path: "./",
			sources: [
				"src/rnn_vad_weights.cc",
			],
			publicHeadersPath: "include_rnn_vad",
			cSettings: [
				.headerSearchPath("include_rnn_vad/rnn_vad")
			]
		),
        .target(
            name: "rnnoise",
			dependencies: [
				"rnn_vad"
			],
			path: "./",
			sources: [
				"src/celt_lpc.c",
				"src/denoise.c",
				"src/kiss_fft.c",
				"src/pitch.c",
				"src/rnn.c",
				"src/rnn_data.c",
				"src/rnn_reader.c",
			],
			publicHeadersPath: "include/",
			cSettings: [
				.headerSearchPath("src/"),
				.headerSearchPath("config/"),
				.define("HAVE_CONFIG_H")
			]
		),
	],
	cLanguageStandard: .gnu11,
	cxxLanguageStandard: .gnucxx20
)
