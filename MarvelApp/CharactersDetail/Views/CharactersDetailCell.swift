//
//  DetailLabelCell.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 22/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

final class CharactersDetailCell: UITableViewCell, CodeView, Reusable {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let txtLabel: UILabel = {
        let text = UILabel()
        text.numberOfLines = 0
        return text
    }()
    
    func buildHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(txtLabel)
    }
    
    func buildConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.left.right.top.equalTo(contentView).offset(16)
        }
        
        self.txtLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.left.bottom.right.equalTo(contentView).offset(16)
        }
    }
    
    private func setup(title: String?, text: String?) {
        titleLabel.text = title
        txtLabel.text = text
    }
    
    func populateCell(viewModel: BaseItem) {
        setup(title: viewModel.name, text: viewModel.description)
    }
}

