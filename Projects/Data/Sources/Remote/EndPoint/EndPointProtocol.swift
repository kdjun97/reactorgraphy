//
//  EndPointProtocol.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

protocol EndPointProtocol {
    var path: EndPointPath { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryParameters: Encodable? { get }
    var requestBody: Encodable? { get }
}
