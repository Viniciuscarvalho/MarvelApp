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
            return String(describing: DetailLabelCell.self)
        case .text:
            return String(describing: DetailTextCell.self)
        }
    }
    
    public func populateCell(_ cell: UITableViewCell?) {
        guard let cell = cell else { return }
        switch self {
        case .label(let title, let text):
            guard let labelCell = cell as? DetailLabelCell else { return }
            labelCell.setup(title: title, text: text)
            break
        case .text(let title, let text):
            guard let labelCell = cell as? DetailTextCell else { return }
            labelCell.setup(title: title, text: text)
            break
        }
    }
}
