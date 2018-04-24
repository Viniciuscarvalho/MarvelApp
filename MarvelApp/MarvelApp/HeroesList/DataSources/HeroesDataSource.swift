//
//  HeroesDataSource.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation
import UIKit

class HeroesDataSource: NSObject {
    
    fileprivate var characters: [Character]
    fileprivate var viewModel: CharactersViewModelProtocol?
    var isSearching: Bool = false
    
    init(with characters: [Character]) {
        self.characters = characters
        super.init()
    }
}


