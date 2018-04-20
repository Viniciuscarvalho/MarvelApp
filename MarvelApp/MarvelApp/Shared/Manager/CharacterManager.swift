//
//  CharacterManager.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 20/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol CharactersManagerDelegate: class {
    func finishLoadPage(error: Error?)
    func searchResult(data: [Character]?, error: Error?)
}

class CharactersManager {
    
    weak var delegate: CharactersManagerDelegate?
    private var characters: [Any]?
    private var page = 0
    private var pageSize = 20
    private var total = 0
    
    private let pathForResource = "/v1/public/characters"
    
    init(delegate: CharactersManagerDelegate) {
        self.delegate = delegate
    }
    
    fileprivate func getParams() -> [String: String] {
        let params = ["limit": "\(pageSize)", "offset": "\(page * pageSize)"]
        return params
    }
    
    func doSearch(name: String) {
        let request = Endpoints(path: self.pathForResource, params: ["name": name])
        APIClient<Character>.get(request) { result in
            switch result {
            case .success(let value):
                guard let value = value as? PayloadRequest<Character> else { return }
                self.delegate?.searchResult(data: value.data.results, error: nil)
            case .error(let error):
                self.delegate?.searchResult(data: nil, error: error)
            }
        }
    }
    
    func getPage() {
        guard (self.total / pageSize) <= page else { return }
        
        let request = Endpoints(path: self.pathForResource, params: getParams())
        APIClient<MarvelApp.Character>.get(request) { result in
            switch result {
            case .success(let value):
                guard let value = value as? PayloadRequest<MarvelApp.Character> else {
                    self.delegate?.finishLoadPage(error: nil) ; return
                }
                //Adicionar item via coreData
                self.total = value.data.count
                self.delegate?.finishLoadPage(error: nil)
                self.page += 1
            case .error(let error):
                self.delegate?.finishLoadPage(error: error)
            }
        }
    }
}
