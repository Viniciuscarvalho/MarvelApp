//
//  DetailLabelCell.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import SnapKit

final class CharactersDetailCell: UITableViewCell, CodeView {
    
//    @IBOutlet fileprivate var titleLabel: UILabel!
//    @IBOutlet fileprivate var txtLabel: UILabel!
    
    //Build elements on view
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let text: UILabel = {
        let text = UILabel()
        return text
    }()
    
    func buildHierarchy() {
        addSubview(contentView)
    }
    
    func buildConstraints() {
        <#code#>
    }
    
    private func setup(title: String?, text: String?) {
        self.titleLabel.text = title
        self.txtLabel.text = text
        
    }
    
    func populateCell(viewModel: BaseItem) {
        setup(title: viewModel.name, text: viewModel.description)
    }
}

