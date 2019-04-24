//
//  CharactersViewModel.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 21/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation
import UIKit

class CharactersViewModel: Hashable, Codable, BaseItem {
    static func == (lhs: CharactersViewModel, rhs: CharactersViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let id: Int
    var name: String?
    var description: String?
    let modified: String
    let thumbnail: Thumbnail?
    let resourceURI: String!
    let comics: CharacterComics?
    let series: CharacterSeries?
    let stories: CharacterStories?
    let events: CharacterEvents?
    let urls: [Url]?
    
    public var hashValue: Int { return id }
    
}
