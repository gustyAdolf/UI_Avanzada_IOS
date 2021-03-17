//
//  CategoriesCoordinator.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import UIKit

/// Coordinator que representa el tab del categories list
class CategoriesCoordinator: Coordinator {
    let presenter: UINavigationController
    let categoriesDataManager: CategoriesDataManager

    init(presenter: UINavigationController, categoriesDataManager: CategoriesDataManager) {
        self.categoriesDataManager = categoriesDataManager
        self.presenter = presenter
    }

    override func start() {
        let categoriesViewModel = CategoriesViewModel(categoriesDataManager: categoriesDataManager)
        let categoriesViewController = CategoriesViewController(viewModel: categoriesViewModel)
        categoriesViewModel.viewDelegate = categoriesViewController
        categoriesViewController.title = NSLocalizedString("Categories", comment: "")
        presenter.pushViewController(categoriesViewController, animated: false)
    }
    
    override func finish() {}
}

