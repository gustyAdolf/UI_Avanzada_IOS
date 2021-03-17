//
//  TopicsViewModel.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import Foundation

protocol TopicsCoordinatorDelegate: class {
    func didSelect(topic: Topic)
    func topicsPlusButtonTapped()
}

protocol TopicsViewDelegate: class {
    func topicsFetched()
    func errorFetchingTopics()
}

class TopicsViewModel {
    weak var coordinateDelegate: TopicsCoordinatorDelegate?
    weak var viewDelegate: TopicsViewDelegate?
    let topicsDataManager: TopicsDataManager
    var cellViewModels: [CellViewModel] = []
    
    init(topicsDataManager: TopicsDataManager) {
        self.topicsDataManager = topicsDataManager
    }
    
    fileprivate func fetchTopicsAndReloadUI() {
        topicsDataManager.fetchAllTopics { [weak self] result in
            switch result {
                case .success(let response):
                    guard let response = response else {return}
                    self?.cellViewModels = response.topicList.topics.map(
                        {
                            TopicCellViewModel(topic: $0,
                                               userTopicOwner: self?.getUserFromTopic(userId: $0.posters[0].userID, latestTopics: response),
                                               topicDataManager: self?.topicsDataManager)
                        })
                    self?.cellViewModels.insert(WelcomeCellViewModel(), at: 0)
                    self?.viewDelegate?.topicsFetched()
                case .failure:
                    self?.viewDelegate?.errorFetchingTopics()
            }
        }
    }
    
    func viewWasLoaded() {
        fetchTopicsAndReloadUI()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return cellViewModels.count
    }
    
    func viewModel(at indexPath: IndexPath) -> CellViewModel? {
        guard indexPath.row < cellViewModels.count else {return nil}
        return cellViewModels[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard indexPath.row < cellViewModels.count,
              let topicCellViewModel = cellViewModels[indexPath.row] as? TopicCellViewModel else {return}
        coordinateDelegate?.didSelect(topic: topicCellViewModel.topic as Topic)
    }
    
    func plusButtonTapped() {
        coordinateDelegate?.topicsPlusButtonTapped()
    }
    
    func newTopicWasCreated() {
        fetchTopicsAndReloadUI()
    }
    
    func topicWasDeleted() {
        fetchTopicsAndReloadUI()
    }
    
    private func getUserFromTopic(userId: Int, latestTopics: LatestTopicsResponse) -> User? {
        guard latestTopics.users.count > 0 else {return nil}
        return latestTopics.users.first { (usr) -> Bool in
            return userId == usr.id
        }
    }
}
