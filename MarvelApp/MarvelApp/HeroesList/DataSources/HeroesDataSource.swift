//
//  HeroesDataSource.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation
import UIKit

class HeroesDataSource: NSObject {
    
    fileprivate var characters: [Character]
    fileprivate var selectedCharacter: Character?
    fileprivate var viewModel: CharactersViewModelProtocol?
    var isSearching: Bool = false
    
    init(with characters: [Character]) {
        self.characters = characters
        super.init()
    }
    
}

extension HeroesDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let total = self.viewModel?.countData() ?? 0
        return total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeroesCollectionViewCell.self), for: indexPath)
        
        nextPage(index: indexPath.row)
        
        if let characterCell = cell as? HeroesCollectionViewCell,
            let character = self.viewModel?.character(index: indexPath.row) {
            characterCell.setup(character: character, viewModel: self.viewModel)
        }
        return cell
    }
    
    fileprivate func nextPage(index: Int) {
        guard let total =  self.viewModel?.countData() else { return }
        guard index > Int(Double(total) * 0.7) else { return }
        self.viewModel?.loadData()
    }
}

extension HeroesDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height / 2.5
        let collectionPadding = CGFloat(45)
        let collectionWidth = collectionView.bounds.width - collectionPadding
        let cellWidth = collectionWidth / 2
        
        return CGSize(width: cellWidth, height: cellHeight);
    }
}
