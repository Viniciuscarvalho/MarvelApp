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
    
    func MD5(string: String) -> Data {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        return digestData
    }

}
