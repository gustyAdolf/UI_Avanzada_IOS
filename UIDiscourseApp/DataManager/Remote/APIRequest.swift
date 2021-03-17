//
//  APIRequest.swift
//  UIDiscourseApp
//
//  Created by Gustavo A Ramírez Franco on 10/3/21.
//

import Foundation

let apiURL = "https://mdiscourse.keepcoding.io"

enum Method: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol APIRequest {
    associatedtype Response: Codable
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
    var body: [String: Any] { get }
    var headers: [String: String] { get }
}

// Default Implementation of the protocol
extension APIRequest {
    var baseURL: URL {
        guard let baseURL = URL(string: apiURL) else {
                fatalError("URL not valid")
        }
        return baseURL
    }
    
    func requestWithBaseUrl() -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            fatalError("Not able to create components")
        }
        
        if !parameters.isEmpty {
            components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
        }
        
        guard let finalUrl = components.url else {
            fatalError("Unable to retrieve final URL")
        }
        
        var request = URLRequest(url: finalUrl)
        request.httpMethod = method.rawValue
        
        if !body.isEmpty {
            let jsonData = try? JSONSerialization.data(withJSONObject: body)
            request.httpBody = jsonData
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("699667f923e65fac39b632b0d9b2db0d9ee40f9da15480ad5a4bcb3c1b095b7a", forHTTPHeaderField: "Api-Key")
        request.addValue("gustyAdolf", forHTTPHeaderField: "Api-Username")
        
        return request
    }
    
}
