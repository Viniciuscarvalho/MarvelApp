//
//  CharacterManager.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 20/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol CharactersManagerProtocol {
    func fetchCharactersData(completion: @escaping (Result<[Character]>) -> Void)
    func searchCharacters(name: String)
    func resetSearch()
}

class CharactersManager: CharactersManagerProtocol {

    private let client: ClientProtocol
    private var characters: [Any]?
    
    private var page = 0
    private var pageSize = 20
    private var total = 0
    
    var isLoadCharacters: Bool = false
    
    private let pathForResource = "/v1/public/characters"
    
    init(client: ClientProtocol) {
        self.client = client
    }
    
    fileprivate func getParams() -> [String: String] {
        let params = ["limit": "\(pageSize)", "offset": "\(page * pageSize)"]
        return params
    }
    
    func resetSearch() {
        characters = nil
        page = 0
        total = 0
    }
    
    func searchCharacters(name: String) {
        let request = ServiceSetup(path: self.pathForResource, params: ["name": name])
        client.requestData(with: request) { result in
            switch result {
            case .success(let value):
                    guard let value = value as? PayloadRequest<Character> else { return }
                    presentResultSearch(data: value.data.results)
            case .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCharactersData(completion: @escaping (Result<[Character]>) -> Void) {
        guard (self.total / pageSize) <= page, !isLoadCharacters else { return }
        isLoadCharacters = true
        
        let request = ServiceSetup(path: self.pathForResource, params: getParams())
        client.requestData(with: request) { result in
            self.isLoadCharacters = false
            switch result {
            case let .success(data):
                do {
                    let decoder = JSONDecoder()
                    let charactersList = try decoder.decode([Character].self, from: data)
                    completion(.success(charactersList))
                } catch {
                    completion(.failure(.couldNotParseObject))
                }
                
                self.total = data.count
                self.page += 1
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


