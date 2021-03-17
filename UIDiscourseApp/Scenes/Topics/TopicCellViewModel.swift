//
//  TopicCellViewModel.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import Foundation

protocol TopicCellViewModelDelegate: class {
    func userImageFetched()
}

/// ViewModel que representa un topic en la lista
class TopicCellViewModel: CellViewModel {
    weak var viewDelegate: TopicCellViewModelDelegate?
    let topic: Topic
    let userTopicOwner: User?
    let topicTitle: String
    let postsCount: String
    let lastPostedAt: String
    let numberOfPosters: String
    var userDataImage: Data?
    let topicDataManager: TopicsDataManager
    
    init(topic: Topic, userTopicOwner: User?, topicDataManager: TopicsDataManager?) {
        self.topic = topic
        self.userTopicOwner = userTopicOwner
        self.topicTitle = topic.title
        self.postsCount = String(topic.postsCount)
        self.lastPostedAt = topic.lastPostedAt
        self.numberOfPosters = String(topic.posters.count)
        guard let topicDataManager = topicDataManager else {fatalError()}
        self.topicDataManager = topicDataManager
        super.init()
        getUserImageData()
       
    }
    
    private func getUserImageData() {
        guard let user = userTopicOwner else {return}
        topicDataManager.fetchUserImage(imageUrlReference: user.avatarTemplate) { [weak self] result in
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
