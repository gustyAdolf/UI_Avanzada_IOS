//
//  CategoriesResponse.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

struct CategoriesResponse: Codable {
    let categoryList: CategoryList

    enum CodingKeys: String, CodingKey {
        case categoryList = "category_list"
    }
}

struct CategoryList: Codable {
    let categories: [Category]
}

struct Category: Codable {
    let name: String
}
