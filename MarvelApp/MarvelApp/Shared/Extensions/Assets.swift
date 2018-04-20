//
//  Assets.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 20/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

enum Assets: String {
    case favoriteEmpty = "favorite_empty_icon"
    case favoriteFull = "favorite_full_icon"
    case favoriteGray = "favorite_gray_icon"
    case logo = "Splash"
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}

