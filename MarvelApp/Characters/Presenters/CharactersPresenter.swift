//
//  CharactersPresenter.swift
//  MarvelApp
//
//  Created by vinicius.marques on 29/03/19.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol CharactersPresenterProtocol: class {
    func presentCharactersList(characters: [Character])
    func presentResultSearch(characters: [Character])
    func presentError(error: ServiceError)
}

class CharactersPresenter: CharactersPresenterProtocol {
    
    weak var viewController: CharactersDisplayProtocol?
    var characters: [Character] = []
    
    func presentCharactersList(characters: [Character]) {
        let characters = characters
        self.characters.append(contentsOf: characters)
    }
    
    func presentResultSearch(characters: [Character]) {
        self.characters = characters
    }
    
    func presentError(error: ServiceError) {
        viewController?.displayError(message: error.localizedDescription)
    }
}
