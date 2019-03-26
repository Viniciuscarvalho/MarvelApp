//
//  SaveManager.swift
//  MarvelApp
//
//  Created by vinicius.marques on 26/03/2019.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import Foundation

class FavoritedCharacterProvider: NSObject {
    
    func save(character: Character) {
        let id = "F\(character.id)"
        UserDefaults.standard.set(true, forKey: id)
        UserDefaults.standard.synchronize()
    }
    
    func remove(character: Character) {
        let id = "F\(character.id)"
        UserDefaults.standard.removeObject(forKey: id)
        UserDefaults.standard.synchronize()
    }
    
    func isFavorited(character: Character) -> Bool {
        let id = "F\(character.id)"
        return UserDefaults.standard.bool(forKey: id)
    }
}
