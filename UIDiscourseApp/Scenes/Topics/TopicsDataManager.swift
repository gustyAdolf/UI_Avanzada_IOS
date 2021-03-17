//
//  TopicsDataManager.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import Foundation

/// Errores que pueden darse en el topics data manager
enum TopicsDataManagerError: Error {
    case unknown
}

/// Data Manager con las opraciones necesarias de este módulo
protocol TopicsDataManager: UserImageService {
    func fetchAllTopics(completion: @escaping (Result<LatestTopicsResponse?, Error>) -> ())
}
