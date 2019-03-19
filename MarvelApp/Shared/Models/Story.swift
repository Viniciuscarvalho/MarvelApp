//
//  Story.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

class Story: ResourceURI, BaseItem {
    
    var resourceURI : String!
    var name : String?
    var id: Int?
    var title: String?
    var description: String?
    var type: String?
    var modified: String?
    var thumbnail: Thumbnail?
    var etag: String?
    
    func isLoaded() -> Bool {
        return (self.title != nil)
    }
    
    func populate(item: Story) {
        self.id = item.id
        self.title = item.title
        self.description = item.description
        self.type = item.type
        self.modified = item.modified
        self.thumbnail = item.thumbnail
        self.etag = item.etag
    }
}
