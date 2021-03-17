//
//  CategoryCell.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import UIKit

class CategoryCell: UITableViewCell {

    var viewModel: CategoryCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            textLabel?.text = viewModel.textLabelText
        }
    }
}
