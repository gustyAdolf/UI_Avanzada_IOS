//
//  CategoriesRequest.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

class CategoriesRequest: APIRequest {
    typealias Response = CategoriesResponse

    var method: Method {
        return .GET
    }

    var path: String {
        return "/categories.json"
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
