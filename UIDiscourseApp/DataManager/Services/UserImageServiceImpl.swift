//
//  UserImageServiceImpl.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 16/3/21.
//

import Foundation

class UserImageServiceImpl: UserImageService {
    func fetchUserImage(imageUrlReference: String, completion: @escaping (Result<Data?, Error>) -> ()) {
       let request = UserImageRequest(imageUrl: imageUrlReference).requestWithBaseUrl()
       let session = URLSession(configuration: .default)
       let task = session.dataTask(with: request) { (data, response, error) in
           guard let data = data else {return}
           DispatchQueue.main.async {
               completion(.success(data))
           }
       }
       task.resume()
   }

}
