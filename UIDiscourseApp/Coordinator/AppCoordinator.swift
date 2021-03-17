//
//  AppCoordinator.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 9/3/21.
//

import UIKit

class AppCoordinator: Coordinator {
    let sessionAPI = SessionAPI()
    
    lazy var remoteDataManager: DiscourseClientRemoteDataManager = {
        let remoteDataManager = DiscourseClientRemoteDataManagerImpl(session: sessionAPI)
        return remoteDataManager
    }()
    
    lazy var localDataManager: DiscourseClientLocalDataManager = {
        let localDataManager = DiscourseClientLocalDataManagerImpl()
        return localDataManager
    }()
    
    lazy var dataManager: DiscourseClientDataManager = {
        let dataManager = DiscourseClientDataManager(localDataManager: localDataManager, remoteDataManager: remoteDataManager)
        return dataManager
    }()
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    override func start() {
        let tabBarController = UITabBarController()
        
        let topicsNavigationController = UINavigationController()
        let topicsCoordinator = TopicsCoordinator(presenter: topicsNavigationController,
                                                  topicsDataManager: dataManager, topicDetailDataManager: dataManager,
                                                  addTopicDataManager: dataManager,
                                                  userDataManager: dataManager)
        addChildCoordinator(topicsCoordinator)
        topicsCoordinator.start()
        
        let usersNavigationController = UINavigationController()
        let usersCoordinator = UsersCoordinator(presenter: usersNavigationController, usersDataManager: dataManager, userDataManager: dataManager)
        addChildCoordinator(usersCoordinator)
        usersCoordinator.start()
        
        tabBarController.tabBar.tintColor = .black
        tabBarController.viewControllers = [topicsNavigationController, usersNavigationController]
        tabBarController.tabBar.items?.first?.image = UIImage(named: "tab_ico_topic")
        tabBarController.tabBar.items?[1].image = UIImage(named: "tab_ico_users")
        
        tabBarController.tabBar.items?.first?.selectedImage = UIImage(named: "tab_ico_topic_selected")
        tabBarController.tabBar.items?[1].selectedImage = UIImage(named: "tab_ico_users_selected")
        
        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    override func finish() {
        
    }
}
