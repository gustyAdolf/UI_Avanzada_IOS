//
//  UsersRequest.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

class UsersRequest: APIRequest {
    typealias Response = UsersResponse

    var method: Method {
        return .GET
    }

    var path: String {
        return "/directory_items.json"
    }

    var parameters: [String : String] {
        return ["period": "all"]
    }

    var body: [String : Any] {
        return [:]
    }

    var headers: [String : String] {
        return [:]
    }
}
