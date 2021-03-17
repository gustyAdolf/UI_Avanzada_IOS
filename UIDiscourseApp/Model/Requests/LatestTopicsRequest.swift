//
//  LatestTopicsRequest.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

/// Implementación de la request que obtiene los latest topics
struct LatestTopicsRequest: APIRequest {
    
    typealias Response = LatestTopicsResponse
    
    var method: Method {
        return .GET
    }
    
    var path: String {
        return "/latest.json"
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    var body: [String : Any] {
        return [:]
    }
    
    var headers: [String : String] {
        return [:]
    }

}
