//
//  CCRecorderApp.swift
//  ProjectDescriptionHelpers
//
//  Created by 김용우 on 2023/10/26.
//

import ProjectDescription
import Foundation

extension TargetDependency {
    public static let ccrecorderApp: TargetDependency = target(name: CCRecorderApp.name)
}

let infoPlist: InfoPlist = .extendingDefault(
    with: [
        "CFBundleVersion": "1",
        "CFBundleShortVersionString": "1.1.2",
        "UISupportedInterfaceOrientations" : ["UIInterfaceOrientationPortrait"],
        "UILaunchStoryboardName": "LaunchScreen",
        "UIApplicationSceneManifest": [
            "UIApplicationSupportsMultipleScenes": false,
            "UISceneConfigurations": [
                "UIWindowSceneSessionRoleApplication": [
                    [
                        "UISceneConfigurationName": "Default Configuration",
                        "UISceneDelegateClassName": "$(PRODUCT_MODULE_NAME).SceneDelegate"
                    ],
                ]
            ]
        ],
        "CFBundleDisplayName": "\(projectName).$(APP_BUNDLE_ID_POST_FIX)",
        "NSMicrophoneUsageDescription": "사용자의 대화를 녹음 하기위해 앱에서 마이크 접근 허용을 요청합니다 (필수)",
        "Supports opening documents in place": "YES"
    ]
)

public struct CCRecorderApp {
    public static let name: String = .init(describing: Self.self)
    public static let packages: [Package] = [

    ]
    
    public static let target: Target = .init(
        name: CCRecorderApp.name,
        platform: .iOS,
        product: .app,
        bundleId: "com.\(organizationName).\(projectName.lowercased()).$(APP_BUNDLE_ID_POST_FIX)",
        deploymentTarget: .appTarget,
        infoPlist: infoPlist,
        sources: ["App/Sources/**"],
        resources: ["App/Resources/**"],
        copyFiles: nil,
        headers: nil,
        entitlements: nil,
        scripts: [],
        dependencies: [
            .commonLayer,
            
            .dataLayer,
            .domainLayer,
            .presentationLayer
        ],
        settings: .settings(configurations: ConfigurationInfo.default),
        coreDataModels: [],
        environmentVariables: [:],
        launchArguments: [],
        additionalFiles: [],
        buildRules: [],
        mergedBinaryType: .disabled,
        mergeable: false
    )
    
    public static let configurationName: ConfigurationName = ConfigurationName(stringLiteral: "\(name)")
    public static let schemes: [Scheme] = [
        .make(name: "\(name).dev",      for: .debug,    targets: ["\(name)"]),
        .make(name: "\(name).sandbox",  for: .sandbox,  targets: ["\(name)"]),
        .make(name: "\(name).test",     for: .test,     targets: ["\(name)"]),
        .make(name: "\(name).release",  for: .release,  targets: ["\(name)"])
    ]
}

