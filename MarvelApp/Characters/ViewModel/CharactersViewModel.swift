//
//  CharactersViewModel.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 21/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation
import UIKit

protocol CharactersViewModelLoadable {
    func reloadElements()
}

protocol CharactersViewModelProtocol {
    func fetchCharacters()
    func countCharacters() -> Int
    func character(index: Int) -> Character?
    var searchString : String? { get set }
}

final class CharactersViewModel: CharactersViewModelProtocol, CharactersManagerDelegate {
    
    fileprivate var loadableData: CharactersViewModelLoadable?
    fileprivate var managerProvider: CharactersManager?
    fileprivate var characters : [Character]?
    
    var fetchingNewCharacters: Bool = false
    
    var searchString: String? {
        didSet {
            if let searchString = searchString, !searchString.isEmpty {
                managerProvider?.doSearch(name: searchString)
            } else {
                managerProvider?.resetSearch()
                managerProvider?.fetchCharactersData()
                characters = nil
            }
        }
    }
    
    init() {
        setup()
    }
    
    func setup(loadableData: CharactersViewModelLoadable?) {
        self.loadableData = loadableData
    }
    
    func setup() {
        managerProvider = CharactersManager(delegate: self)
    }
    
    func fetchCharacters() {
        managerProvider?.fetchCharactersData()
    }
    
    func character(index: Int) -> Character? {
        if let searchHeroes = characters {
            guard index < searchHeroes.count else { return nil }
            return searchHeroes[index]
        }
        return nil
    }
    
    func countCharacters() -> Int {
        if let searchHeroes = characters {
            return searchHeroes.count
        }
        return 0
    }
    
}

extension CharactersViewModel {
    func finishLoadPage(data: [Character]?, error: Error?) {
        guard error == nil else { return }
        guard let data = data else { return }
        self.characters = data
        loadableData?.reloadElements()
    }
    
    func searchResult(data: [Character]?, error: Error?) {
        guard error == nil else { return }
        self.characters = data
        loadableData?.reloadElements()
    }
    
}
