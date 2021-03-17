//
//  DiscourseClientRemoteDataManagerImpl.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import Foundation

class DiscourseClientRemoteDataManagerImpl: DiscourseClientRemoteDataManager {
    let session: SessionAPI

    init(session: SessionAPI) {
        self.session = session
    }

    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        let request = LatestTopicsRequest()
        session.send(request: request) { result in
            completion(result)
        }
    }

    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        let request = SingleTopicRequest(id: id)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        let request = CreateTopicRequest(title: title, raw: raw, createdAt: createdAt)
        session.send(request: request) { result in
            completion(result)
        }
    }

    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        let request = DeleteTopicRequest(id: id)
        session.send(request: request) { (result) in
            completion(result)
        }
    }

    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        let request = CategoriesRequest()
        session.send(request: request) { (result) in
            completion(result)
        }
    }

    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        let request = UsersRequest()
        session.send(request: request) { (result) in
            completion(result)
        }
    }

    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ()) {
        let request = UserRequest(username: username)
        session.send(request: request) { (result) in
            completion(result)
        }
    }

    func updateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ()) {
        let request = UpdateUserNameRequest(username: username, name: name)
        session.send(request: request) { (result) in
            completion(result)
        }
    }
    
}
