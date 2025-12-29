//
//  ProjectEnvironment.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

public struct ProjectEnvironment: @unchecked Sendable {
    public let appName: String
    public let targetName: String
    public let organizationName: String
    public let bundleIdentifier: String
    public let deploymentTargets: DeploymentTargets
    public let destination: Destinations
}

public let projectEnvironment = ProjectEnvironment(
    appName: "ReactorGraphy",
    targetName: "ReactorGraphy",
    organizationName: "jumy",
    bundleIdentifier: "com.jumy.reactorgraphy",
    deploymentTargets: .iOS("16.0"),
    destination: .iOS
)
