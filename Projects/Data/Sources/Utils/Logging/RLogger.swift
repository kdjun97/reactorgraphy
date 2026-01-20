//
//  RLogger.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

import OSLog

public enum RLogLevel: String {
    case DEBUG
    case NETWORK
    case ERROR
    
    var prefix: String {
        switch self {
        case .DEBUG:
            return "🟡 [Debug]"
        case .NETWORK:
            return "🟠 [Network]"
        case .ERROR:
            return "🔴 [Error]"
        }
    }
}

public struct RLogger {
    private let logger: Logger
    private let level: RLogLevel
    
    private init(level: RLogLevel) {
        let subSystem = Bundle.main.bundleIdentifier ?? "com.jumy.reactorgraphy"
        self.logger = Logger(subsystem: subSystem, category: level.rawValue)
        self.level = level
    }
    
    public static let debug = RLogger(level: .DEBUG)
    public static let network = RLogger(level: .NETWORK)
    public static let error = RLogger(level: .ERROR)
    
    public func log(
        _ message: String,
        _ args: CVarArg...,
        function: String = #function,
        file: String = #file,
        line: Int = #line
    ) {
        let formattedString = String(format: message, arguments: args)
        let fileName = (file as NSString).lastPathComponent
        let metadata = "[\(function) => \(fileName):\(line)]"
        let fullMessage = "\(level.prefix)\n\(formattedString)"
        let messageWithMetaData = """
        \(level.prefix)
        \(metadata)
        \(formattedString)
        """

        switch level {
        case .DEBUG:
            logger.debug("\(messageWithMetaData, privacy: .private)")
        case .NETWORK:
            logger.notice("\(fullMessage)")
        case .ERROR:
            logger.error("\(fullMessage)")
        }
    }
}
