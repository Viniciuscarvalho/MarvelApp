//
//  CharacterDetailProviderFields.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

enum CharacterDetailProviderFields {
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
        return String(describing: DetailLabelCell.self)
    }
    
    public func populateCell(_ cell: UITableViewCell?) {
        guard let cell = cell else { return }
        guard let labelCell = cell as? DetailLabelCell else { return }
        labelCell.setup(title: "Name", text: "TESTE")
    }
}
