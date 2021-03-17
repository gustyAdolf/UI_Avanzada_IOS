//
//  TopicDetailDataManager.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

/// DataManager con las operaciones necesarias de este módulo
protocol TopicDetailDataManager: class {
    func fetchTopic(id: Int, completion: @escaping (Result<SingleTopicResponse?, Error>) -> ())
    func deleteTopic(id: Int, completion: @escaping (Result<DeleteTopicResponse?, Error>) -> ())
}
