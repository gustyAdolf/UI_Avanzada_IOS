//
//  TopicsCoordinator.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import UIKit

class TopicsCoordinator: Coordinator {
    let presenter: UINavigationController
    let topicsDataManager: TopicsDataManager
    let userDataManager: UserDataManager
    var topicsViewModel: TopicsViewModel?
    let addTopicDataManager: AddTopicDataManager
    let topicDetailDataManager: TopicDetailDataManager

    
    init(presenter: UINavigationController, topicsDataManager: TopicsDataManager,
         topicDetailDataManager: TopicDetailDataManager,
         addTopicDataManager: AddTopicDataManager, userDataManager: UserDataManager) {
        self.presenter = presenter
        self.topicsDataManager = topicsDataManager
        self.topicDetailDataManager = topicDetailDataManager
        self.addTopicDataManager = addTopicDataManager
        self.userDataManager = userDataManager
    }
    
    override func start() {
        let topicsViewModel = TopicsViewModel(topicsDataManager: topicsDataManager)
        let topicsController = TopicsViewController(viewModel: topicsViewModel)
        topicsController.title = NSLocalizedString("Topics", comment: "")
        topicsViewModel.viewDelegate = topicsController
        topicsViewModel.coordinateDelegate = self
        self.topicsViewModel = topicsViewModel
        presenter.pushViewController(topicsController, animated: false)
    }
    
    override func finish() {
        
    }
}

extension TopicsCoordinator: TopicsCoordinatorDelegate {
    func didSelect(topic: Topic) {
        let topicDetailViewModel = TopicDetailViewModel(topicID: topic.id, topicDetailDataManager: topicDetailDataManager)
        topicDetailViewModel.coordinatorDelegate = self
        let topicDetailViewController = TopicDetailViewController(viewModel: topicDetailViewModel)
        topicDetailViewModel.viewDelegate = topicDetailViewController
        presenter.pushViewController(topicDetailViewController, animated: true)
    }

    func topicsPlusButtonTapped() {
        let addTopicCoordinator = AddTopicCoordinator(presenter: presenter, addTopicDataManager: addTopicDataManager)
        addChildCoordinator(addTopicCoordinator)
        addTopicCoordinator.start()

        addTopicCoordinator.onCancelTapped = { [weak self] in
            guard let self = self else { return }

            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
        }

        addTopicCoordinator.onTopicCreated = { [weak self] in
            guard let self = self else { return }

            addTopicCoordinator.finish()
            self.removeChildCoordinator(addTopicCoordinator)
            self.topicsViewModel?.newTopicWasCreated()
        }
    }
}

extension TopicsCoordinator: TopicDetailCoordinatorDelegate {
    func topicDetailBackButtonTapped() {
        presenter.popViewController(animated: true)
    }

    func topicSuccessfullyDeleted() {
        presenter.popViewController(animated: true)
        topicsViewModel?.topicWasDeleted()
    }
}
