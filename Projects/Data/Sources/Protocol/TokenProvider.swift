//
//  TokenProvider.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

public protocol TokenProvider {
    func getAccessToken() -> String
    func setAccessToken(_ accessToken: String)
}
