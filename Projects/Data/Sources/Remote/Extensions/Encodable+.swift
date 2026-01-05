//
//  Encodable+.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

import Foundation

extension Encodable {
    func toDictionary() throws -> [String: Any]? {
        let data = try JSONEncoder().encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data)
        return jsonObject as? [String: Any]
    }
}
