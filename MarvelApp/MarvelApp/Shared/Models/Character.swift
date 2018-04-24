//
//  Character.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

struct CharacterComics: Codable {
    var available: Int
    var collectionURI: String
    var items: [Comic]
}

struct CharacterSeries: Codable {
    var available: Int
    var collectionURI: String
    var items: [Serie]
}

struct CharacterEvents: Codable {
    var available: Int
    var collectionURI: String
    var items: [Event]
}

struct CharacterStories: Codable {
    var available: Int
    var collectionURI: String
    var items: [Story]
}

struct Character: Hashable, Codable, BaseItem {
    static func == (lhs: Character, rhs: Character) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    let id: Int
    var name: String?
    var description: String?
    let modified: String
    let thumbnail: Thumbnail?
    let resourceURI: String
    let comics: CharacterComics?
    let series: CharacterSeries?
    let stories: CharacterStories?
    let events: CharacterEvents?
    let urls: [Url]?
    
    public var hashValue: Int { return id }
}

