//
//  UsersDataManager.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

protocol UsersDataManager: UserImageService {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
}
