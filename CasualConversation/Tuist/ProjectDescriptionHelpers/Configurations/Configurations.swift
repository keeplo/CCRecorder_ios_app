//
//  Configurations.swift
//  ProjectDescriptionHelpers
//
//  Created by 김용우 on 2023/10/25.
//

import ProjectDescription

public extension ConfigurationName {
    static let sandbox: Self = .configuration("Sandbox")
    static let test: Self = .configuration("Test")
}

public struct ConfigurationInfo {
    
    public static let `default`: [Configuration] = [
        .debug(name: .debug,        settings: ConfigurationInfo(.debug).settings),
        .debug(name: .sandbox,      settings: ConfigurationInfo(.sandbox).settings),
        .debug(name: .test,         settings: ConfigurationInfo(.test).settings),
        .release(name: .release,    settings: ConfigurationInfo(.release).settings)
    ]
        
    private let configurationName: ConfigurationName
    
    init(_ configurationName: ConfigurationName) {
        self.configurationName = configurationName
    }
    
    public var settings: SettingsDictionary {
        SettingsDictionary()
            .merging(APP_BUNDLE_ID_POST_FIX)
            .merging(SWIFT_ACTIVE_COMPILATION_CONDITIONS)
            .merging(DEVELOPMENT_TEAM)
            .merging(DEBUG_INFORMATION_FORMAT)
    }
    
    private var condition: String {
        switch configurationName {
            case .sandbox:      return "SANDBOX"
            case .test:         return "TEST"
            case .release:      return "RELEASE"
            case .debug:        fallthrough
            default:            return "DEBUG"
        }
    }
    
    private var rawValue: String {
        switch configurationName {
            case .sandbox:      return "sandbox"
            case .test:         return "test"
            case .release:      return "release"
            case .debug:        fallthrough
            default:            return "dev"
        }
    }
    
    private var APP_BUNDLE_ID_POST_FIX: SettingsDictionary {
        ["\(#function)": "\(rawValue)"]
    }
    
    private var SWIFT_ACTIVE_COMPILATION_CONDITIONS: SettingsDictionary {
        ["\(#function)": "\(condition)"]
    }
    
    private var DEVELOPMENT_TEAM: SettingsDictionary {
        ["\(#function)": "9486RJPBM5"]
    }
    
    private var DEBUG_INFORMATION_FORMAT: SettingsDictionary {
        ["\(#function)": "DWARF with dSYM File"]
    }
}
