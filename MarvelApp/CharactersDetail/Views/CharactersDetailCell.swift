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

final class CharactersDetailCell: UITableViewCell, CodeView {
    
    //Build elements on view
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let txtLabel: UILabel = {
        let text = UILabel()
        return text
    }()
    
    init() {
        super.init(style: .default, reuseIdentifier: "")
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(txtLabel)
    }
    
    func buildConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.leading.equalTo(Metric.large)
            make.top.equalTo(Metric.large)
            make.bottom.equalTo(txtLabel.snp.bottom).offset(Metric.small)
        }
        
        self.txtLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.leading.equalTo(Metric.large)
            make.bottom.equalTo(Metric.large)
            make.top.equalTo(Metric.small)
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

