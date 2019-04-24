//
//  CharactersInteractor.swift
//  MarvelApp
//
//  Created by vinicius.marques on 29/03/19.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol CharactersInteractorProtocol {
    func listCharacters()
    func countCharacters() -> Int
    func character(index: Int) -> Character
    var searchString: String? { get set }
}

class CharactersInteractor: CharactersInteractorProtocol {
    private var manager: CharactersManagerProtocol?
    private var presenter: CharactersPresenterProtocol?
    
    init(presenter: CharactersPresenterProtocol, manager: CharactersManagerProtocol) {
        self.presenter = presenter
        self.manager = manager
    }
    
    var searchString: String? {
        didSet {
            if let searchString = searchString, !searchString.isEmpty {
                manager?.searchCharacters(name: searchString)
            } else {
                manager?.resetSearch()
                listCharacters()
            }
        }
    }
    
    func listCharacters() {
        manager?.fetchCharactersData { [weak self] (result) in
            guard let interactor = self else { return }
            switch result {
            case let .success(characters):
                interactor.presenter?.presentCharactersList(characters: character(index: IndexPath.row))
            }
        }
    }
    
    func character(index: Int) -> Character {
        let searchHeroes = presenter.character
        searchHeroes.count
        
        return searchHeroes[index]
        
    }
    
    func countCharacters() -> Int {
        let searchHeroes = presenter.character
        return searchHeroes.count
    }
    
}
