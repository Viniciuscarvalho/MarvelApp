//
//  CodeView.swift
//  MarvelApp
//
//  Created by vinicius.marques on 12/12/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

protocol CodeView {
    func buildHierarchy()
    func buildConstraints()
    func configure()
    func setupView()
}

extension CodeView {
    func setupView() {
        buildHierarchy()
        buildConstraints()
        configure()
    }
    
    func configure() {}
}
