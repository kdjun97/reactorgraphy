//
//  BaseURL.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

import Foundation

public enum BaseUrl {
    public static var current: String {
        guard let url = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as? String else {
            fatalError("API_BASE_URL not set in Info.plist")
        }
        return url
    }
}
