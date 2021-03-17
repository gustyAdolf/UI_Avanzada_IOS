//
//  CategoriesDataManager.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

protocol CategoriesDataManager: class {
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ())
}
