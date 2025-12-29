//
//  Scheme+Extension.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

import ProjectDescription

extension Scheme {
    static func implements(targetName: String) -> Scheme {
        return Scheme.scheme(
            name: targetName,
            shared: true,
            buildAction: .buildAction(targets: ["\(targetName)"]),
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .release),
            profileAction: .profileAction(configuration: .release),
            analyzeAction: .analyzeAction(configuration: .debug)
        )
    }
}
