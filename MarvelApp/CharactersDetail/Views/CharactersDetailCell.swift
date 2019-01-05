//
//  DetailLabelCell.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

final class CharactersDetailCell: UITableViewCell {
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var txtLabel: UILabel!
    
    private func setup(title: String?, text: String?) {
        self.titleLabel.text = title
        self.txtLabel.text = text
    }
    
    func populateCell(viewModel: BaseItem) {
        setup(title: viewModel.name, text: viewModel.description)
    }
}
