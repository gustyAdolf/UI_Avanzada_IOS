//
//  DiscourseClientDataManager.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import Foundation


class DiscourseClientDataManager {
    let localDataManager: DiscourseClientLocalDataManager
    let remoteDataManager: DiscourseClientRemoteDataManager
    let userImageService: UserImageService

    init(localDataManager: DiscourseClientLocalDataManager, remoteDataManager: DiscourseClientRemoteDataManager,
         userImageService: UserImageService = UserImageServiceImpl()) {
        self.localDataManager = localDataManager
        self.remoteDataManager = remoteDataManager
        self.userImageService = userImageService
    }
}

extension DiscourseClientDataManager: TopicsDataManager {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllTopics(completion: completion)
    }
}

extension DiscourseClientDataManager: TopicDetailDataManager {
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ()) {
        remoteDataManager.fetchTopic(id: id, completion: completion)
    }

    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ()) {
        remoteDataManager.deleteTopic(id: id, completion: completion)
    }
}

extension DiscourseClientDataManager: AddTopicDataManager {
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ()) {
        remoteDataManager.addTopic(title: title, raw: raw, createdAt: createdAt, completion: completion)
    }
}

extension DiscourseClientDataManager: CategoriesDataManager {
    func fetchAllCategories(completion: @escaping (Result<CategoriesResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllCategories(completion: completion)
    }
}

extension DiscourseClientDataManager: UsersDataManager {
    func fetchAllUsers(completion: @escaping (Result<UsersResponse?, Error>) -> ()) {
        remoteDataManager.fetchAllUsers(completion: completion)
    }
}

extension DiscourseClientDataManager: UserDataManager {
    func fetchUser(username: String, completion: @escaping (Result<UserResponse?, Error>) -> ()) {
        remoteDataManager.fetchUser(username: username, completion: completion)
    }

    func updateUserName(username: String, name: String, completion: @escaping (Result<UpdateUserNameResponse?, Error>) -> ()) {
        remoteDataManager.updateUserName(username: username, name: name, completion: completion)
    }
}

extension DiscourseClientDataManager: UserImageService {
    func fetchUserImage(imageUrlReference: String, completion: @escaping (Result<Data?, Error>) -> ()) {
        self.userImageService.fetchUserImage(imageUrlReference: imageUrlReference, completion: completion)
    }
}
