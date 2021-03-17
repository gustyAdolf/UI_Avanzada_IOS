//
//  UserImageRequest.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 14/3/21.
//

import Foundation

struct UserImageRequest: APIRequest {
    typealias Response = Data
    
    let imageUrl: String
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
    }
    
    var method: Method = .GET
    
    var path: String {
        return self.imageUrl.replacingOccurrences(of: "{size}", with: "200")
    }
    
    var parameters: [String : String] = [:]
    
    var body: [String : Any] = [:]
    
    var headers: [String : String] = [:]
    
}
