//
//  DiscourseClientRemoteDataManager.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import Foundation

protocol DiscourseClientRemoteDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ())
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ())
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ())
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ())
    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ())
    func updateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ())
}
