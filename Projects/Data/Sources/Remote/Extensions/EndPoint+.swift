//
//  EndPoint+.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

import Foundation

extension EndPoint {
    func makeURLRequest(url: URL, accessToken: String) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 30
        urlRequest.httpMethod = self.method.rawValue
        if let headers = self.headers {
            headers.forEach { key, value in
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let tokenString: String = accessToken.isEmpty ? "" : "Client-ID \(accessToken)"

        urlRequest.setValue(tokenString, forHTTPHeaderField: "Authorization")
        urlRequest.setValue("UTF-8", forHTTPHeaderField: "Accept-Charset")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        return urlRequest
    }
}
