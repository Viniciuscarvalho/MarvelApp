//
//  Result.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

enum Result {
    case success(Codable?)
    case error(APIError)
}
