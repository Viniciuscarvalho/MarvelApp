//
//  HeroesViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

final class HeroesViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet weak var load: UIActivityIndicatorView!
    
    fileprivate var originFrame: CGRect?
    fileprivate var originImage: UIImage?
    
    fileprivate var viewModel: CharactersViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        self.viewModel = CharactersViewModel(loadableData: self)
        self.viewModel?.loadData()
        self.registerCell()
        self.navigationController?.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.reloadElements()
    }
    
    func registerCell() {
        let nib = UINib(nibName: "HeroesCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "HeroesCollectionViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailCharacterSegue" else { return }
        if let index = sender as? Int {
            guard let destination = segue.destination as? HeroesDetailViewController else { return }
            guard let item = self.viewModel?.character(index: index) else { return }
            destination.viewModel = CharactersDetailViewModel(character: item)
        } else if let item = sender as? Character {
            guard let destination = segue.destination as? HeroesDetailViewController else { return }
            destination.viewModel = CharactersDetailViewModel(character: item)
        }
    }
}

extension HeroesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let total = self.viewModel?.countData() ?? 0
        if total > 0 {
            load.stopAnimating()
        }
        return total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HeroesCollectionViewCell.self), for: indexPath)
                
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

extension HeroesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height / 2.5
        let collectionPadding = CGFloat(45)
        let collectionWidth = collectionView.bounds.width - collectionPadding
        let cellWidth = collectionWidth / 2
        
        return CGSize(width: cellWidth, height: cellHeight);
    }
}

extension HeroesViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        guard let frame = self.originFrame else { return nil }
        guard let image = self.originImage else { return nil }
        
        switch operation {
        case .push:
            return CharacterAnimation(originFrame: frame, image: image, isShow: true)
        default:
            return CharacterAnimation(originFrame: frame, image: image)
        }
    }
}

extension HeroesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theAttributes = collectionView.layoutAttributesForItem(at: indexPath)
        if let cell = collectionView.cellForItem(at: indexPath) as? HeroesCollectionViewCell,
            let frame = theAttributes?.frame {
            self.originImage = cell.image()
            self.originFrame = collectionView.convert(frame, to: collectionView.superview)
        }
        self.performSegue(withIdentifier: "detailCharacterSegue", sender: indexPath.row)
    }
}
extension HeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.searchString = searchText
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        self.viewModel?.searchString = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

extension HeroesViewController: CharactersViewModelLoadable {
    func reloadElements() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


