//
//  UserImageService.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 16/3/21.
//

import Foundation

protocol UserImageService: class {
    func fetchUserImage(imageUrlReference: String, completion: @escaping (Result<Data?, Error>) -> ())
}
