//
//  DependencyInfo.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

public struct DependencyInfo: @unchecked Sendable {
    let moduleDependencies: [ModuleType: [ModuleType]]
}

public let dependencyInfo: DependencyInfo = DependencyInfo(
    moduleDependencies: [
        .App: [
            .Presentations(.Root),
            .Data,
            .DI
        ],
        .Domain: [.DI],
        .Data: [.Domain],
        .DI: [.External(.Swinject)],
        .Presentations(.Root): [.Presentations(.Base)],
        .Presentations(.Base): [
            .Domain,
            .DesignSystem,
            .External(.ReactorKit),
            .External(.RxSwift),
            .External(.RxCocoa),
            .External(.RxRelay),
        ]
    ]
)
