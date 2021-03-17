//
//  UsersResponse.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

struct UsersResponse: Codable {
    let directoryItems: [DirectoryItem]

    enum CodingKeys: String, CodingKey {
        case directoryItems = "directory_items"
    }
}

struct DirectoryItem: Codable {
    let user: User
}
