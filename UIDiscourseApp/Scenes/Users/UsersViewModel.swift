//
//  UsersViewModel.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

protocol UsersViewModelCoordinatorDelegate: class {
    func didSelect(user: User, userImage: Data)
}

protocol UsersViewModelViewDelegate: class {
    func usersWereFetched()
    func errorFetchingUsers()
}

/// ViewModel representando un listado de usuarios
class UsersViewModel {
    weak var coordinatorDelegate: UsersViewModelCoordinatorDelegate?
    weak var viewDelegate: UsersViewModelViewDelegate?
    var userViewModels: [UserCellViewModel] = []
    let usersDataManager: UsersDataManager

    init(usersDataManager: UsersDataManager) {
        self.usersDataManager = usersDataManager
    }

    func viewWasLoaded() {
        usersDataManager.fetchAllUsers { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let response = response else { return }

                self?.userViewModels = response.directoryItems.map({ UserCellViewModel(user: $0.user, userDataManager: self?.usersDataManager) })
                self?.viewDelegate?.usersWereFetched()
            case .failure:
                self?.viewDelegate?.errorFetchingUsers()
            }
        }
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfRows(in section: Int) -> Int {
        return userViewModels.count
    }

    func viewModel(at indexPath: IndexPath) -> UserCellViewModel? {
        guard indexPath.row < userViewModels.count else { return nil }
        return userViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        coordinatorDelegate?.didSelect(user: userViewModels[indexPath.row].user, userImage: userViewModels[indexPath.row].userDataImage ?? Data())
    }
}
