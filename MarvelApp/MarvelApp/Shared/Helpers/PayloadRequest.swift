//
//  PayloadRequest.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

struct PayloadData<T: Codable> : Codable {
    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]
}

struct PayloadRequest<T: Codable> : Codable {
    let code: Int
    let status: String
    let etag: String
    let data: PayloadData<T>
}
