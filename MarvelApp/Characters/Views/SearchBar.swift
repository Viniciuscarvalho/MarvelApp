//
//  SearchBar.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 05/01/19.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import UIKit

class SearchBar: UISearchBar {
    
    var viewModel: CharactersViewModelProtocol?
    
    init() {
        super.init(frame: .zero)
        delegate = self
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
            textField.backgroundColor = UIColor.black
        }
    }
}

extension SearchBar: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.searchString = searchText
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        self.viewModel?.searchString = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}
