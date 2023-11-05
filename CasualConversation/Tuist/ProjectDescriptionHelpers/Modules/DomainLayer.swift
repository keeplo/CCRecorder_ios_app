//
//  DomainLayer.swift
//  CCRecorderAppsManifests
//
//  Created by 김용우 on 2023/10/25.
//

import ProjectDescription

extension TargetDependency {
    public static let domainLayer: TargetDependency = target(name: DomainLayer.name)
}

public struct DomainLayer {
    public static let name: String = .init(describing: Self.self)
    public static let packages: [Package] = []
    public static let target: Target = .init(
        name: name,
        platform: .iOS,
        product: .framework,
        productName: nil,
        bundleId: "com.pseapplications.casualconversation.\(name)",
        deploymentTarget: .appTarget,
        infoPlist: .default,
        sources: ["../../Module/\(name)/Sources/**"],
        resources: [],
        copyFiles: nil,
        headers: nil,
        entitlements: nil,
        scripts: [],
        dependencies: [
            .commonLayer
        ],
        settings: nil,
        coreDataModels: [],
        environmentVariables: [:],
        launchArguments: [],
        additionalFiles: [],
        buildRules: [],
        mergedBinaryType: .automatic
    )
    public static let test: Target = .init(
        name: name + "Tests",
        platform: .iOS,
        product: .unitTests,
        bundleId: "com.anipen.\(name)Tests",
        infoPlist: .default,
        sources: ["../../Module/\(name)/Tests/**"],
        resources: [],
        dependencies: [
            .domainLayer,
            
            .quick,
            .nimble
        ]
    )

}
