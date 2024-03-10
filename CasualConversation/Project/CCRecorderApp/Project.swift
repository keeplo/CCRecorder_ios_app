import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// MARK: - Project
let project: Project = .init(
    name: CCRecorderApp.name,
    organizationName: organizationName,
    options: options,
    packages: [
        CCRecorderApp.packages,
        
        DataLayer.packages,
        DomainLayer.packages,
        PresentationLayer.packages
    ].flatMap({ $0 }),
    settings: .settings(configurations: ConfigurationInfo.default),
    targets: [
        CCRecorderApp.target,
        
        // Modules
        CommonLayer.target,
        CommonLayer.test,
        
        DataLayer.target,
        DataLayer.test,
        
        DomainLayer.target,
        DomainLayer.test,
        
        PresentationLayer.target,
        PresentationLayer.test
    ],
    schemes: CCRecorderApp.schemes,
    fileHeaderTemplate: nil,
    additionalFiles: [],
    resourceSynthesizers: []
)
