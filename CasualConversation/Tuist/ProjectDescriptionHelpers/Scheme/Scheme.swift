//
//  Scheme.swift
//  AniLanguageAppManifests
//
//  Created by 김용우 on 2023/10/25.
//

import ProjectDescription

public extension Scheme {
    
    static func make(
        name: String,
        for configuration: ConfigurationName,
        arguments: ProjectDescription.Arguments? = Arguments(
            launchArguments: [.init(name: "FIRAnalyticsDebugEnabled", isEnabled: true)]
        ),
        diagnosticsOptions: [SchemeDiagnosticsOption] = [.mainThreadChecker, .performanceAntipatternChecker],
        targets: [TargetReference] = []
    ) -> Scheme {
        Scheme(
            name: "\(name) [\(configuration.description)]",
            buildAction: .buildAction(targets: targets),
            testAction: .testPlans([], configuration: configuration),
            runAction: .runAction(
                configuration: configuration,
                executable: targets.first,
                arguments: arguments,
                diagnosticsOptions: diagnosticsOptions
            ),
            archiveAction: .archiveAction(configuration: configuration),
            profileAction: .profileAction(configuration: configuration),
            analyzeAction: .analyzeAction(configuration: configuration)
        )
    }
    
}
