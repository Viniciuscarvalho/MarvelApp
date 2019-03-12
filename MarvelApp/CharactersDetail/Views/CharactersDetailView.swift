//
//  CharactersDetailView.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 10/12/18.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation
import UIKit

class CharactersDetailView: UIView, CodeView {
    
    //Build elements on view
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    private let text: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildHierarchy() {
        <#code#>
    }
    
    func buildConstraints() {
        <#code#>
    }
    
    
}
