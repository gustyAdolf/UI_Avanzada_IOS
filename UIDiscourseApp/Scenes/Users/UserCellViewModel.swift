//
//  UsersCellViewModel.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

protocol UserCellViewModelViewDelegate: class {
    func userImageFetched()
}

class UserCellViewModel {
    weak var viewDelegate: UserCellViewModelViewDelegate?
    let user: User
    let textLabelText: String?
    var userDataImage: Data?
    let userDataManager: UsersDataManager
    
    init(user: User, userDataManager: UsersDataManager?) {
        self.user = user
        textLabelText = user.name ?? "¡Sin Nombre!"
        guard let userDataManager = userDataManager else {fatalError()}
        self.userDataManager = userDataManager
        getUserImageData()
    }
    
    
    private func getUserImageData() {
        userDataManager.fetchUserImage(imageUrlReference: user.avatarTemplate) { [weak self] result in
            switch result {
                case .success(let data):
                    guard let data = data else {
                        return
                    }
                    self?.userDataImage = data
                    self?.viewDelegate?.userImageFetched()
                case .failure(let error):
                    print(error)
            }
        }
    }
}
