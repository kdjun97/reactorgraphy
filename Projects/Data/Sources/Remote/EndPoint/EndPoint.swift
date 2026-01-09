//
//  EndPoint.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

struct EndPoint<T>: EndPointProtocol {
    public var path: EndPointPath
    public var method: HTTPMethod
    public var headers: [String: String]?
    public var queryParameters: Encodable?
    public var requestBody: Encodable?
    
    public init(
        path: EndPointPath,
        method: HTTPMethod,
        headers: [String: String]? = nil,
        queryParameters: Encodable? = nil,
        requestBody: Encodable? = nil
    ) {
        self.path = path
        self.method = method
        self.headers = headers
        self.queryParameters = queryParameters
        self.requestBody = requestBody
    }
}

extension EndPoint {
    static func getRandomPhoto() -> EndPoint<T> {
        return EndPoint(path: .randomPhoto, method: .GET)
    }
}
