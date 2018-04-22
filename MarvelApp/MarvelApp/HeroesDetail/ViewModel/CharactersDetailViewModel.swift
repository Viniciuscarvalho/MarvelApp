//
//  CharactersDetailViewModel.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol CharactersDetailViewModelProtocol {
    func count() -> Int
    func item(index: Int) -> CharacterDetailProviderFields?
}

class CharactersDetailViewModel: CharactersDetailViewModelProtocol {
    
    fileprivate var character: Character?
    fileprivate var cells = [CharacterDetailProviderFields]()
    
    init(character: Character) {
        self.character = character
        cells.append(.label("Name", character.name))
        if let description = character.description, !description.isEmpty {
            cells.append(.text("Description", description))
        }
    }
    
    public func count() -> Int {
        return cells.count
    }
    
    public func item(index: Int) -> CharacterDetailProviderFields?  {
        guard index < cells.count else { return nil }
        return cells[index]
    }
    
}
