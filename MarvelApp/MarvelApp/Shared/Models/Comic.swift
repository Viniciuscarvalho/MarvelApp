//
//  Comic.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

class Comic: Codable, ResourceURI {
    
    let resourceURI: String
    let name: String?
    var id: Int?
    var digitalId: Int?
    var title: String?
    var diamondCode: String?
    var issueNumber: Int?
    var description: String?
    var variantDescription: String?
    var dates: [DateObject]?
    var thumbnail: Thumbnail?
    var images: [Thumbnail]?
    
    func isLoaded() -> Bool {
        return (title != nil)
    }
    
    func populate(item: Comic) {
        self.title = item.title
        self.id = item.id
        self.digitalId = item.digitalId
        self.diamondCode = item.diamondCode
        self.issueNumber = item.issueNumber
        self.description = item.description
        self.variantDescription = item.variantDescription
        self.dates = item.dates
        self.thumbnail = item.thumbnail
        self.images = item.images
    }
}
