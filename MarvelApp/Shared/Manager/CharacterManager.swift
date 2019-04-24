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
    
    func searchCharacters(name: String) {
        let request = ServiceSetup(path: self.pathForResource, params: ["name": name])
        client.requestData(with: request) { result in
            switch result {
            case .success(let value):
                guard let value = value as? PayloadRequest<Character> else { return }
                self.delegate?.presentResultSearch(data: value.data.results)
            case .error(error: ServiceError):
                
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
//                guard let value = value as? PayloadRequest<MarvelApp.Character> else {
//                    self.presenter.
//                    return
//                }
                self.total = data.count
                presenter.presentCharactersList(characters: data.results)
                self.page += 1
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


