//
//  ResourceURI.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol ResourceURI: Codable, AnyObject {
    var resourceURI: String! { get }
    func isLoaded() -> Bool
    func populate(item: Self)
}

extension ResourceURI {
    public func load(callback: @escaping (Bool) -> Void) {
        guard isLoaded() == false else { callback(true) ; return }
        
        let request = ServiceSetup(path: self.resourceURI, params: [:])
        
        APIService<Self>.requestData(request) { result in
            switch result {
            case .success(let value):
                weak var weakSelf = self
                guard let value = value as? PayloadRequest<Self>,
                    let result = value.data.results.first else { return }
                weakSelf?.populate(item: result)
                callback(true)
            
            case .error(let error):
                callback(false)
                print(error)
            }
        }
    }
}
