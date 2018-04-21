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
    var collectionView: UICollectionView
    var isSearching: Bool = false {
        didSet {
            self.reloadCollection()
        }
    }
    
    init(with characters: [Character], collectionView: UICollectionView) {
        self.characters = characters
        self.collectionView = collectionView
        super.init()
    }
    
    func registerCell() {
        let nib = UINib(nibName: "HeroesCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "HeroesCollectionViewCell")
    }
    
    func reloadCollection() {
        collectionView.reloadData()
        postCurrentStateNotification()
    }
    
    func numberOfCharacters() -> Int {
        return characters.count
    }
    
    func getCharacter(byIndexPath indexPath: IndexPath) -> Character {
        let row = indexPath.row
        return characters[row]
    }
    
    func getSelectedCharacters() -> Character? {
        return self.selectedCharacter
    }
    
    func postNotification() {
        NotificationConstants.shouldLoadCharacters.post()
    }
    
    func postItemSelectionNotification() {
        NotificationConstants.shouldHandleItemSelection.post()
    }
    
    fileprivate func postCurrentStateNotification() {
        NotificationConstants.shouldChangeCurrentState.post()
    }
    
}

extension HeroesDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeroesCollectionViewCell", for: indexPath) as? HeroesCollectionViewCell {
            
            let character = self.getCharacter(byIndexPath: indexPath)
            
            cell.setup(character: character)
            return cell
        }
        return UICollectionViewCell()
    }
}

extension HeroesDataSource: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == self.characters.count - 2{
            postNotification()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let characters = self.getCharacter(byIndexPath: indexPath)
        self.selectedCharacter = characters
        postItemSelectionNotification()
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
