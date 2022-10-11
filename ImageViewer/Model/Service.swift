//
//  Service.swift
//  ImageViewer
//
//  Created by Caseyann Goore on 2022-10-11.
//

import Foundation

import UIKit

enum getError : Error{
case wrongUrl
}
class ServiceController {
    static var shared = ServiceController()
    private init() {}
    func fetchImage(imageUrl : String, completion : @escaping(Result<UIImage,Error>)->()) {
        guard let url = URL(string: imageUrl) else {
            return completion(.failure(getError.wrongUrl))
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data, let img = UIImage(data: data) {
                completion(.success(img))
            }
        }
        task.resume()
    }
    
}
