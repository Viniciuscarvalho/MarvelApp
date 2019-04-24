//
//  APIClient.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol ClientProtocol {
    func requestData(with request: ServiceSetup, completion: @escaping (Result<Data>) -> Void)
}

struct APIService: ClientProtocol {
    
    public func requestData(with request: ServiceSetup, completion: @escaping (Result<Data>) -> Void) {
        guard let url = request.generateURL() else {
            completion(.failure(.urlNotFound))
            return
        }
        
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(.unknown(error.localizedDescription)))
                }
                
                guard let data = data else {
                    completion(.failure(.brokenData)) ;
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(.unknown("Could not cast to HTTPURLResponse object.")))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    completion(.success(data))
                    
                case 403:
                    completion(.failure(.authenticationRequired))
                    
                case 404:
                    completion(.failure(.couldNotFindHost))
                    
                case 500:
                    completion(.failure(.badRequest))
                    
                default: break
                }
                }.resume()
        }
        
    }
    
}
