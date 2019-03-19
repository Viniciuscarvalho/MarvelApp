//
//  Serie.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

class Serie: ResourceURI, BaseItem {
    
    var resourceURI: String!
    var name: String?
    var id: Int?
    var title: String?
    var description: String?
    var urls: [Url]?
    var startYear: Int?
    var endYear: Int?
    var rating: String?
    var modified: String?
    var thumbnail: Thumbnail?
    var next: Serie?
    var previous: Serie?
    
    func isLoaded() -> Bool {
        return (title != nil)
    }
    
    func populate(item: Serie) {
        self.id = item.id
        self.title = item.title
        self.description = item.description
        self.urls = item.urls
        self.startYear = item.startYear
        self.endYear = item.endYear
        self.rating = item.rating
        self.modified = item.modified
        self.thumbnail = item.thumbnail
        self.next = item.next
        self.previous = item.previous
    }
}
