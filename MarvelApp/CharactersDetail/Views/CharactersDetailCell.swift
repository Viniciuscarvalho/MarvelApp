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
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let textLabel: UILabel = {
        let text = UILabel()
        return text
    }()
    
    init() {
        super.init(style: <#T##UITableViewCellStyle#>, reuseIdentifier: <#T##String?#>)
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(textLabel)
    }
    
    func buildConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.edges.centerX.equalTo(self)
            make.edges.leading.equalTo(16)
            make.edges.top.equalTo(16)
            make.edges.bottom.equalTo(textLabel.snp.bottom).offset(8)
        }
        
        self.textLabel.snp.makeConstraints { make in
            make.edges.centerX.equalTo(self)
            make.edges.leading.equalTo(16)
            make.edges.bottom.equalTo(16)
            make.edges.top.equalTo(8)
        }
    }
    
    private func setup(title: String?, text: String?) {
        titleLabel.text = title
        textLabel.text = text
        
    }
    
    func populateCell(viewModel: BaseItem) {
        setup(title: viewModel.name, text: viewModel.description)
    }
}

