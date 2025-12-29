//
//  Dependency+Extension.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

public extension Array where Element == TargetDependency {
    static func dependencies(moduleType: ModuleType) -> [TargetDependency] {
        .implements(key: moduleType)
    }
    
    private static func implements(key moduleType: ModuleType) -> [TargetDependency] {
        guard let modules = dependencyInfo.moduleDependencies[moduleType] else { return [] }
        
        return modules.map { module in
            switch module {
            case .App, .Domain, .DesignSystem, .Data, .DI:
                return .project(
                    target: module.name,
                    path: .relativeToRoot("Projects/\(module.name)")
                )
            case .Presentations(let presentation):
                return .project(
                    target: presentation.rawValue,
                    path: .relativeToRoot("Projects/Presentations/\(presentation.rawValue)")
                )
            case .External(let externalModule):
                return .external(name: externalModule.rawValue)
            }
        }
    }
}
