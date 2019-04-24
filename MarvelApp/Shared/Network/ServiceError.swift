//
//  ServiceError.swift
//  MarvelApp
//
//  Created by vinicius.marques on 29/03/19.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case urlNotFound
    case authenticationRequired
    case brokenData
    case couldNotFindHost
    case couldNotParseObject
    case badRequest
    case unknown(String)
    
    var localizedDescription: String {
        switch self {
        case .urlNotFound: return "Could not found URL."
        case .authenticationRequired: return "Authentication is required."
        case .brokenData: return "The received data is broken."
        case .couldNotFindHost: return "The host was not found."
        case .badRequest: return "This is a bad request."
        case .couldNotParseObject: return "Can't convert the data to the object entity."
        case let .unknown(message): return message
        }
    }
}

extension ServiceError: Equatable {
    static func == (lhs: ServiceError, rhs: ServiceError) -> Bool {
        return lhs.localizedDescription = rhs.localizedDescription
    }
}
