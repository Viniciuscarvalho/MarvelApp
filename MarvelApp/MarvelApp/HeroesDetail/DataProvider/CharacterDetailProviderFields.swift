//
//  CharacterDetailProviderFields.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

enum CharacterDetailProviderFields {
    case label(String, String)
    case text(String, String)
}

enum CharacterDataFields {
    case comics([Comic])
    case events([Event])
    case stories([Story])
    case series([Serie])
}

extension CharacterDetailProviderFields {
    public func cellID() -> String {
        switch self {
        case .label:
            return String(describing: DetailLabelTableViewCell.self)
        case .text:
            return String(describing: DetailTextTableViewCell.self)
        }
}
