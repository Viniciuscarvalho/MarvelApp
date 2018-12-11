//
//  HeroesCollectionViewCell.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

protocol FavoriteDelegate: class {
    func save(character: Character?)
}

class CharactersCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: ImageViewAsync!
    @IBOutlet weak var heroesTitle: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    fileprivate var character: Character?
    fileprivate var viewModel: CharactersViewModelProtocol?
    
    fileprivate func clean() {
        self.heroesTitle.text = ""
        self.imageView.image = UIImage(named: "placeholder")
    }
    
    func setFavorite(character: Character) {
        let id = "F\(character.id)"
        
        DispatchQueue.main.async {
            if let status = UserDefaults.standard.value(forKey: id) as? Bool {
                if status {
                    self.favoriteIcon.image = Assets.favoriteFull.image
                }
            }
        }
    }
    
    override func prepareForReuse() {
        self.imageView.image = Assets.logo.image
        self.favoriteIcon.image = Assets.favoriteGray.image
    }
    
    func setup(character: Character, viewModel: CharactersViewModelProtocol? = nil) {
        self.character = character
        self.viewModel = viewModel
        self.heroesTitle?.text = character.name
        self.heroesTitle?.font = UIFont(name: "Avenir", size: 16)
        if let path = character.thumbnail?.path, let ext = character.thumbnail?.extension {
            self.imageView?.imageFromServerURL(urlString: "\(path).\(ext)")
        }
        self.setFavorite(character: character)
        
    }
    
    public func image() -> UIImage? {
        return imageView.image
    }
}
