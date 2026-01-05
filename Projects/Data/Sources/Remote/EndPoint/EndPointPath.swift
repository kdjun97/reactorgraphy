//
//  EndPointPath.swift
//  Data
//
//  Created by 김동준 on 1/5/26
//

enum EndPointPath {
    case photos
    case randomPhoto
    case photoDetail(String)
    
    var value: String {
        switch self {
        case .photos:
            "/photos"
        case .randomPhoto:
            "/photos/random"
        case .photoDetail(let id):
            "/photos/\(id)"
        }
    }
}
