//
//  AddTopicDataManager.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 11/3/21.
//

import Foundation

/// DataManager con las operaciones necesarias para este módulo
protocol AddTopicDataManager: class {
    func addTopic(title: String, raw: String, createdAt: String, completion: @escaping (Result<AddNewTopicResponse?, Error>) -> ())
}
