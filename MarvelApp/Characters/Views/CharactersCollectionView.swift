//
//  CharactersView.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 10/12/18.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import SnapKit

class CharactersCollectionView: UIView, CodeView {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var searchBar: SearchBar = SearchBar()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    lazy var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0 )
        flowLayout.minimumInteritemSpacing = 4
        flowLayout.minimumLineSpacing = 4
        return flowLayout
    }()
    
    func buildHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(collectionView)
    }
    
    func buildConstraints() {
        self.searchBar.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(self)
        }
        
        self.collectionView.snp.makeConstraints { make in
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.top.equalTo(searchBar.snp.bottom)
            make.bottom.equalTo(self)
        }
    }
}

