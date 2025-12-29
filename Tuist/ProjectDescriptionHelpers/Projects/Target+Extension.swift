//
//  Target+Extension.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

public extension Target {
    static func target(moduleType: ModuleType) -> Target {
        let resources: ResourceFileElements? = moduleType.hasResources ? ["Resources/**"] : nil
        let infoPlist: InfoPlist = moduleType.infoPlist
        
        return Target.implements(
            name: moduleType.name,
            product: moduleType.product,
            resources: resources,
            infoPlist: infoPlist,
            dependencies: .dependencies(moduleType: moduleType)
        )
    }
    
    static func designSystemDemo(moduleType: ModuleType) -> Target {
        return Target.target(
            name: "\(moduleType.name)Demo",
            destinations: projectEnvironment.destination,
            product: .app,
            bundleId: "\(projectEnvironment.bundleIdentifier)-demo",
            deploymentTargets: projectEnvironment.deploymentTargets,
            infoPlist: .file(path: "Demo/Support/Info.plist"),
            sources: ["Demo/Sources/**"],
            resources: ["Demo/Resources/**"],
            dependencies: [.project(
                target: ModuleType.DesignSystem.name,
                path: .relativeToRoot("Projects/\(ModuleType.DesignSystem.name)")
            )],
            settings: .settings(
                base: [
                    "PRODUCT_NAME": "\(moduleType.name)Demo",
                    "BUNDLE_IDENTIFIER": "\(projectEnvironment.bundleIdentifier)-demo",
                    "BUNDLE_NAME": "\(moduleType.name)Demo"
                ]
            )
        )
    }
}

// MARK: Implement
private extension Target {
    static func implements(
        name: String,
        product: Product,
        resources: ResourceFileElements? = nil,
        infoPlist: InfoPlist,
        dependencies: [TargetDependency]
    ) -> Target {
        Target.target(
            name: name,
            destinations: projectEnvironment.destination,
            product: product,
            bundleId: projectEnvironment.bundleIdentifier,
            deploymentTargets: projectEnvironment.deploymentTargets,
            infoPlist: infoPlist,
            sources: ["Sources/**"],
            resources: resources,
            dependencies: dependencies
        )
    }
}
