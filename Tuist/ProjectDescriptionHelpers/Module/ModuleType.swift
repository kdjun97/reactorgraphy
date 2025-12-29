//
//  ModuleType.swift
//  BaseTemplateManifests
//
//  Created by 김동준 on 9/7/25
//

public enum ModuleType: Hashable {
    case App
    case Domain
    case Presentations(PresentationModuleType)
    case External(ExternalModuleType)
    case DesignSystem
    case Data
    case DI
}

public enum ExternalModuleType: String {
    case Swinject
    case ReactorKit
    case RxSwift
    case RxCocoa
    case RxRelay
}

public enum PresentationModuleType: String {
    case Root
    case Base
}
