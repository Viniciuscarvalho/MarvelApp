//
//  SearchBar.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 05/01/19.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {
    
    init() {
        super.init(frame: .zero)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        print("this class can not be initilized for NSCoder arg")
        return nil
    }
    
    fileprivate func setup() {
        self.barTintColor = UIColor.gray
        self.isTranslucent = false
        self.backgroundImage = UIImage()
        self.returnKeyType = .done
        self.placeholder = "Search"
        if let textField = self.value(forKey: "searchField") as? UITextField {
            textField.backgroundColor = UIColor.white
        }
    }
}
