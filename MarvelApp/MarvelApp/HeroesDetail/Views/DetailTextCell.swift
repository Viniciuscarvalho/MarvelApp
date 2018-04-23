//
//  DetailTextCell.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

final class DetailTextCell: UITableViewCell {
    
    @IBOutlet fileprivate var titleLabel: UILabel!
    @IBOutlet fileprivate var textFieldLabel: UITextView!
    
    func setup(title: String, text: String) {
        self.titleLabel.text = title
        self.textFieldLabel.text = text
    }
}
