//
//  CharactersDetailView.swift
//  MarvelApp
//
//  Created by vinicius.marques on 25/03/2019.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import UIKit
import SnapKit

class CharactersDetailView: UIView, CodeView {
    
    private var character: Character?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = UIColor.white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Mark: Setup view
    private let content: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        return table
    }()
    
    lazy var photo: ImageViewAsync = {
        let imageView = ImageViewAsync()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Assets.logo.image
        return imageView
    }()
    
    lazy var favorite: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(Assets.favoriteEmpty.image, for: .normal)
        return button
    }()
    
    func buildHierarchy() {
        addSubview(content)
        content.addSubview(photo)
        content.addSubview(favorite)
        addSubview(tableView)
    }
    
    func buildConstraints() {
        self.content.snp.makeConstraints { make in
            make.top.equalTo(safeAreaInsets.top)
            make.left.right.equalTo(self)
            make.height.equalTo(478)
        }
        
        self.photo.snp.makeConstraints { make in
            make.edges.equalTo(self.content)
        }
        
        self.favorite.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.right.equalTo(self.content).offset(-Metric.large)
            make.bottom.equalTo(tableView.snp.top).offset(-27)
        }
        
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.content.snp.bottom)
            make.left.right.bottom.equalTo(self)
        }
    }
    
    func setup(character: Character) {
        self.character = character
        
        if let path = character.thumbnail?.path, let ext = character.thumbnail?.extension {
            self.photo.imageFromServerURL(urlString: "\(path).\(ext)")
        }
    }
    
    public func image() -> UIImage? {
        return photo.image
    }
}
