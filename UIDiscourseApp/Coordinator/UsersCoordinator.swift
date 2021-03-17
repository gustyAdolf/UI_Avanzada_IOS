//
//  UsersCoordinator.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import UIKit

class UsersCoordinator: Coordinator {
    let presenter: UINavigationController
    let usersDataManager: UsersDataManager
    let userDataManager: UserDataManager
    
    init(presenter: UINavigationController, usersDataManager: UsersDataManager, userDataManager: UserDataManager) {
        self.userDataManager = userDataManager
        self.usersDataManager = usersDataManager
        self.presenter = presenter
    }
    
    override func start() {
        let usersViewModel = UsersViewModel(usersDataManager: usersDataManager)
        let usersViewController = UsersViewController(viewModel: usersViewModel)
        usersViewModel.viewDelegate = usersViewController
        usersViewModel.coordinatorDelegate = self
        usersViewController.title = NSLocalizedString("Users", comment: "")
        presenter.pushViewController(usersViewController, animated: false)
    }
    
    override func finish() {}
}

extension UsersCoordinator: UsersViewModelCoordinatorDelegate {
    func didSelect(username: String, userImage: Data) {
        let userViewModel = UserViewModel(username: username, userImage: userImage ,userDataManager: userDataManager)
        let userViewController = UserViewController(viewModel: userViewModel)
        userViewModel.viewDelegate = userViewController
        userViewController.title = NSLocalizedString(username, comment: "")
        presenter.present(userViewController, animated: true, completion: nil)
    }
}

