//
//  HeroesCollectionViewCell.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

class HeroesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView?
    @IBOutlet weak var heroesTitle: UILabel?
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    func setup(character: Character) {
        self.heroesTitle?.text = character.name
        self.heroesTitle?.font = UIFont(name: "Avenir", size: 16)
        self.setFavorite(character: character)
    }
    
    private func setFavorite(character: Character) {
        let heroesController = HeroesController()
        if heroesController.isFavoriteHero(character: character) {
            favoriteIcon.image = Assets.favoriteFull.image
        } else {
            favoriteIcon.image = Assets.favoriteGray.image
        }
    }
    
}
