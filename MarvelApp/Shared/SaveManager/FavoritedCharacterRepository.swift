//
//  FavoritedCharacterRepository.swift
//  MarvelApp
//
//  Created by vinicius.marques on 26/03/2019.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import Foundation

struct FavoritedCharacterRepository {
    
    let provider: FavoritedCharacterProvider
    init(provider: FavoritedCharacterProvider = FavoritedCharacterProvider()) {
        self.provider = provider
    }
    
    func toggleFavorite(character: Character) {
        if provider.isFavorited(character: character) {
            provider.remove(character: character)
        } else {
            provider.save(character: character)
        }
    }
    
    func isFavorited(character: Character) -> Bool {
        return provider.isFavorited(character: character)
    }
    
}
