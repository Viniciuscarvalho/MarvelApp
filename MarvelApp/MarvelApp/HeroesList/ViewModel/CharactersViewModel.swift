//
//  CharactersViewModel.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 21/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol CharactersViewModelLoadable {
    func reloadData()
}

protocol CharactersViewModelProtocol {
    func loadData()
    func countData() -> Int
    func character(index: Int) -> Character?
    var searchString : String? { get set }
}

final class CharactersViewModel: CharactersViewModelProtocol, CharactersManagerDelegate {
    
    fileprivate var managerProvider: CharactersManager?
    fileprivate var loadableData: CharactersViewModelLoadable?
    fileprivate var searchResult : [Character]?
    
    var searchString: String? {
        didSet {
            if let searchString = searchString, !searchString.isEmpty {
                managerProvider?.doSearch(name: searchString)
            } else {
                searchResult = nil
            }
        }
    }
    
    init(loadableData: CharactersViewModelLoadable?) {
        self.loadableData = loadableData
        setup()
    }
    
    func setup() {
        self.managerProvider = CharactersManager(delegate: self)
    }
    
    func loadData() {
        self.managerProvider?.getPage()
    }
    
    func countData() -> Int {
        if let searchHeroes = searchResult {
            return searchHeroes.count
        }
        return 0
    }
    
    func character(index: Int) -> Character? {
        if let searchHeroes = searchResult {
            guard index < searchHeroes.count else { return nil }
            return searchHeroes[index]
        }
        return nil
    }
    
}

extension CharactersViewModel {
    func finishLoadPage(data: [Character]?, error: Error?) {
        guard error == nil else { return }
        guard let data = data else { return }
        self.searchResult = data
        loadableData?.reloadData()
    }
    
    func searchResult(data: [Character]?, error: Error?) {
        guard error == nil else { return }
        self.searchResult = data
        loadableData?.reloadData()
    }
    
}
