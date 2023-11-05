//
//  DeploymentTarget.swift
//  AniLanguageAppManifests
//
//  Created by 김용우 on 2023/10/25.
//

import ProjectDescription

public extension DeploymentTarget {
    static let appTarget: Self = .iOS(targetVersion: "15.0", devices: [.iphone])
}
