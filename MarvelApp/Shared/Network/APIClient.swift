//
//  APIClient.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

enum APIError: Error {
    case invalidData, parseError, customError(Error)
}

protocol Client {
    static func get(_ request: Endpoints, callback: @escaping (Result) -> Void)
}

class APIClient<T: Codable>: Client {
    static func get(_ request: Endpoints, callback: @escaping (Result) -> Void) {
        guard let url = request.generateURL() else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                callback(.error(.customError(error)))
            }
            
            guard let data = data else {
                callback(.error(.invalidData)) ;
                return
            }
            
            do {
                let jsonObject = try JSONDecoder().decode(PayloadRequest<T>.self, from: data)
                callback(.success(jsonObject))
            } catch {
                callback(.error(.parseError))
            }
        }
        
        task.resume()
    }

}
