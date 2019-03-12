//
//  CharactersDetailViewModel.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

class CharactersDetailViewModel {
    var output: [String: [BaseItem]]
    
    init(character: Character) {
        var output = [String: [BaseItem]]()
        
        output["Character"] = [character]
        
        if let comics = character.comics, !comics.items.isEmpty {
            output["Comics"] = comics.items.getElements(byRange: 0 ..< 3)
        }
        
        if let events = character.events, !events.items.isEmpty {
            output["Events"] = events.items.getElements(byRange: 0 ..< 3)
        }
        
        if let stories = character.stories, !stories.items.isEmpty {
            output["Stories"] = stories.items.getElements(byRange: 0 ..< 3)
        }
        
        if let series = character.series, !series.items.isEmpty {
            output["Series"] = series.items.getElements(byRange: 0 ..< 3)
        }
        
        self.output = output
    }
}

extension Array where Element: BaseItem {
    func getElements(byRange range: Range<Int>) -> [Element] {
        return enumerated().filter({ index, _ in
            return index >= range.lowerBound && index < range.upperBound
        }).map({ _, element in
            return element
        })
    }
}
