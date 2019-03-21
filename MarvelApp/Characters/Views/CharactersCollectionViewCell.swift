//
//  HeroesCollectionViewCell.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

protocol FavoriteDelegate: class {
    func save(character: Character?)
}

final class CharactersCollectionViewCell: UICollectionViewCell, CodeView, Reusable {
    
    private var character: Character?
    private var viewModel: CharactersInteractorProtocol?
    
    //Build elements on view
    private let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = Metric.extraSmall
        return view
    }()
    
    let photo: ImageViewAsync = {
        let imageView = ImageViewAsync()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Metric.extraSmall
        return imageView
    }()
    
    private let name: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.yellow
        return label
    }()
    
    private let footer: UIView = {
        let view = UIView()
        let blueDark = UIColor(red: 44/255.0, green: 48/255.0, blue: 73/255.0, alpha: 1.0)
        view.backgroundColor = blueDark
        return view
    }()
    
    private let favorite: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "favorite_gray_icon"), for: .normal)
        button.tintColor = .gray
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
        
        self.name.snp.makeConstraints { make in
            make.centerY.equalTo(footer.self)
            make.left.equalTo(footer.snp.left).offset(Metric.small)
            make.trailing.equalTo(favorite.snp.leading).offset(-Metric.small)
        }
        
        self.photo.snp.makeConstraints { make in
            make.height.equalTo(content.self)
            make.leading.equalTo(content.self)
            make.trailing.equalTo(content.self)
            make.bottom.equalTo(footer.snp.top)
        }
        
        self.footer.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalTo(content.self)
            make.bottom.equalTo(content.self)
            make.top.equalTo(photo.snp.bottom)
            make.right.equalTo(content.self)
        }
        
        self.favorite.snp.makeConstraints { make in
            make.width.equalTo(Metric.large)
            make.right.equalTo(content.self).inset(Metric.small)
            make.centerY.equalTo(name.snp.centerY)
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
        favoriteAction()
    }
    
    func setup(character: Character, viewModel: CharactersInteractorProtocol? = nil) {
        self.character = character
        self.viewModel = viewModel
        
        self.favoriteAction(character: character)
        self.name.text = character.name
        self.name.font = UIFont(name: "Avenir", size: 16)
        if let path = character.thumbnail?.path, let ext = character.thumbnail?.extension {
            self.photo.imageFromServerURL(urlString: "\(path).\(ext)")
        }
    }
    
    public func image() -> UIImage? {
        return photo.image
    }
    
}
