//
//  UserViewModel.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

protocol UserViewModelViewDelegate: class {
    func errorFetchingUser()
    func userDataFetched()
    func successUpdatingUserName()
    func errorUpdatingUserName()
}

class UserViewModel {
    weak var viewDelegate: UserViewModelViewDelegate?
    let username: String
    let userDataManager: UserDataManager

    var userIDLabelText: String?
    var nameLabelText: String?
    var usernameLabelText: String?
    var userNameUsingTextFieldStackViewIsHidden = true
    var updateNameButtonIsHidden = true
    
    let userImageData: Data

    init(username: String, userImage: Data, userDataManager: UserDataManager) {
        self.userDataManager = userDataManager
        self.username = username
        self.userImageData = userImage
    }

    func viewWasLoaded() {
        userDataManager.fetchUser(username: username) { [weak self] (result) in
            switch result {
            case .success(let response):
                guard let response = response else { return }
                self?.userIDLabelText = "\(response.user.id)"
                self?.nameLabelText = response.user.name
                self?.usernameLabelText = response.user.username
                if response.user.canEditName {
                    self?.userNameUsingTextFieldStackViewIsHidden = false
                    self?.updateNameButtonIsHidden = false
                } else {
                    self?.userNameUsingTextFieldStackViewIsHidden = true
                    self?.updateNameButtonIsHidden = true
                }

                self?.viewDelegate?.userDataFetched()
            case .failure:
                self?.viewDelegate?.errorFetchingUser()
            }
        }
    }

    func updateNameButtonTapped(name: String) {
        userDataManager.updateUserName(username: username, name: name) { [weak self] (result) in
            switch result {
            case .success:
                self?.viewDelegate?.successUpdatingUserName()
            case .failure:
                self?.viewDelegate?.errorUpdatingUserName()
            }
        }
    }
}
