//
//  AuxiliaryModels.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

struct Thumbnail: Codable {
    var path : String
    var `extension` : String
}

struct DateObject: Codable {
    let type: String
    let date: String
}

struct Url: Codable {
    var type : String
    var url : String
}
