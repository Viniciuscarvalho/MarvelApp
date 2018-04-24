//
//  DetailLabelCell.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

enum CharacterDataFields {
    case comics([Comic])
    case events([Event])
    case stories([Story])
    case series([Serie])
}

final class HeroesDetailCell: UITableViewCell {
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var txtLabel: UILabel!
    
    private func setup(title: String, text: String) {
        self.titleLabel.text = title
        self.txtLabel.text = text
    }
    
    func populateCell(viewModel: CharactersDetailViewModel) {
        guard let descriptionCharacter = viewModel.character.descriptionCharacter else { return }
        setup(title: viewModel.character.name, text: descriptionCharacter)
    }
}
