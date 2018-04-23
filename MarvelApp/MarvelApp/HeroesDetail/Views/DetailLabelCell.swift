//
//  DetailLabelCell.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

final class DetailLabelCell: UITableViewCell {
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var txtLabel: UILabel!
    
    func setup(title: String, text: String) {
        self.titleLabel.text = title
        self.txtLabel.text = text
    }
}
