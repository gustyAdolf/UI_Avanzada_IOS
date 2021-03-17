//
//  CategoryCellViewModel.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

class CategoryCellViewModel {
    let category: Category
    let textLabelText: String?

    init(category: Category) {
        self.category = category
        textLabelText = category.name
    }
}
