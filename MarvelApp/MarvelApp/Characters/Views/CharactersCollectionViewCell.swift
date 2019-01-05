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
    
    private var character: Character?
    private var viewModel: CharactersViewModelProtocol?
    
    //Build elements on view
    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Metric.extraSmall
        return view
    }()
    
    private let photo: ImageViewAsync = {
        let imageView = ImageViewAsync()
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
    
    private var favoriteAction: () -> Void = {}
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        installFavoriteAction()
        buildHierarchy()
        buildConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: content.layer.cornerRadius).cgPath
    }
    
    //Build View
    func buildHierarchy() {
        addSubview(content)
        content.addSubview(photo)
        content.addSubview(footer)
        content.addSubview(name)
        content.addSubview(favorite)
        installShadow()
    }
    
    func buildConstraints() {
        self.content.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        self.photo.snp.makeConstraints { make in
            make.edges.height.equalTo(content.self)
            make.edges.leading.equalTo(content.self)
            make.edges.trailing.equalTo(content.self)
        }
        
        self.footer.snp.makeConstraints { make in
            make.edges.leading.equalTo(content.self)
            make.edges.trailing.equalTo(content.self)
            make.edges.bottom.equalTo(content.self)
            make.edges.top.equalTo(photo.snp.bottom)
        }
        
        self.name.snp.makeConstraints { make in
            make.edges.leading.equalTo(footer.snp.leading).offset(Metric.small)
            make.edges.top.equalTo(footer.snp.top).offset(Metric.small)
            make.edges.trailing.equalTo(favorite.snp.leading).offset(-Metric.small)
            make.edges.bottom.equalTo(favorite.snp.bottom).offset(-Metric.small)
        }
        
        self.favorite.snp.makeConstraints { make in
            make.width.equalTo(Metric.large)
            make.centerY.equalTo(name.snp.centerY)
            make.trailing.equalTo(footer.snp.trailing).offset(-Metric.small)
        }
        
    }
    
    private func installShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1.2
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
    
    //Favorite functions
    //    func favoriteAction(character: Character) {
    //        let id = "F\(character.id)"
    //
    //        DispatchQueue.main.async {
    //            if let status = UserDefaults.standard.value(forKey: id) as? Bool {
    //                if status {
    //                    //self.favoriteIcon.image = Assets.favoriteFull.image
    //                }
    //            }
    //        }
    //    }
    
    func addFavoriteAction(action: @escaping () -> Void) {
        favoriteAction = action
    }
    
    private func installFavoriteAction() {
        favorite.addTarget(self, action: #selector(didTouchAtFavorite), for: .touchUpInside)
    }
    
    @objc private func didTouchAtFavorite() {
        favoriteAction()
    }
    
    func setup(character: Character, viewModel: CharactersViewModelProtocol? = nil) {
        self.character = character
        self.viewModel = viewModel
        self.name.text = character.name
        self.name.font = UIFont(name: "Avenir", size: 16)
        if let path = character.thumbnail?.path, let ext = character.thumbnail?.extension {
            self.photo.imageFromServerURL(urlString: "\(path).\(ext)")
        }
        
    }
    
}
