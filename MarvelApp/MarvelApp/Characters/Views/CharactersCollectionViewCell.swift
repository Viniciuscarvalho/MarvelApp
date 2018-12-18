//
//  HeroesCollectionViewCell.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import SnapKit

protocol FavoriteDelegate: class {
    func save(character: Character?)
}

final class CharactersCollectionViewCell: UICollectionViewCell, CodeView {
    
    //Build elements on view
    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Metric.extraSmall
        return view
    }()
    
    private let photo: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Metric.extraSmall
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let footer: UIView = {
        let view = UIView()
        return view
    }()
    
    private let favorite: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Action/HeartOutline"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(didTouchAtFavorite), for: .touchUpInside)
        return button
    }()
    
    //Build view of snapkit
    func buildHierarchy() {
        addSubview(content)
        content.addSubview(photo)
        content.addSubview(footer)
        content.addSubview(name)
        content.addSubview(favorite)
    }
    
    func buildConstraints() {
        self.content.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
    }
    
    //Favorite functions
    func favoriteAction(character: Character) {
        let id = "F\(character.id)"
        
        DispatchQueue.main.async {
            if let status = UserDefaults.standard.value(forKey: id) as? Bool {
                if status {
                    //self.favoriteIcon.image = Assets.favoriteFull.image
                }
            }
        }
    }
    
    func addFavoriteAction(action: @escaping () -> Void) {
        favoriteAction = action
    }
    
    private func installFavoriteAction() {
        favorite.addTarget(self, action: #selector(didTouchAtFavorite), for: .touchUpInside)
    }
    
    @objc private func didTouchAtFavorite() {
        favoriteAction(character: character)
    }

    func setup(character: Character, viewModel: CharactersViewModelProtocol? = nil) {
//        self.character = character
//        self.viewModel = viewModel
//        self.heroesTitle?.text = character.name
//        self.heroesTitle?.font = UIFont(name: "Avenir", size: 16)
//        if let path = character.thumbnail?.path, let ext = character.thumbnail?.extension {
//            self.imageView?.imageFromServerURL(urlString: "\(path).\(ext)")
//        }
        self.favoriteAction(character: character)
        
    }

}
