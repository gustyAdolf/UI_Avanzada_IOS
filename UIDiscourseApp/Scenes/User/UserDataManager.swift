//
//  UserDataManager.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

protocol UserDataManager: class {
    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ())
    func updateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ())
}
