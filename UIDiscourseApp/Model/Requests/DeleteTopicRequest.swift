//
//  DeleteTopicRequest.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

class DeleteTopicRequest: APIRequest {
    typealias Response = DeleteTopicResponse

    let id: Int

    init(id: Int) {
        self.id = id
    }

    var method: Method {
        return .DELETE
    }

    var path: String {
        return "/t/\(id).json"
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
