//
//  Result.swift
//  MarvelApp
//
//  Created by vinicius.marques on 29/03/19.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(ServiceError)
}
