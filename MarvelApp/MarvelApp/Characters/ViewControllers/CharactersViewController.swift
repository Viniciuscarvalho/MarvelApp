//
//  HeroesViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {
    
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
        let nib = UINib(nibName: "CharactersCollectionViewCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: "CharactersCollectionViewCell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailCharacterSegue" else { return }
        if let index = sender as? Int {
            guard let destination = segue.destination as? CharactersDetailViewController else { return }
            guard let item = self.viewModel?.character(index: index) else { return }
            destination.viewModel = CharactersDetailViewModel(character: item)
        } else if let item = sender as? Character {
            guard let destination = segue.destination as? CharactersDetailViewController else { return }
            destination.viewModel = CharactersDetailViewModel(character: item)
        }
    }
}

extension CharactersViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let total = self.viewModel?.countData() ?? 0
        if total > 0 {
            load.stopAnimating()
        }
        return total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CharactersCollectionViewCell.self), for: indexPath)
                
        if let characterCell = cell as? CharactersCollectionViewCell,
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

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height / 2
        let collectionPadding = CGFloat(35)
        let collectionWidth = collectionView.bounds.width - collectionPadding
        let cellWidth = collectionWidth / 2
        
        return CGSize(width: cellWidth, height: cellHeight);
    }
}

extension CharactersViewController: UINavigationControllerDelegate {
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

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let theAttributes = collectionView.layoutAttributesForItem(at: indexPath)
        if let cell = collectionView.cellForItem(at: indexPath) as? CharactersCollectionViewCell,
            let frame = theAttributes?.frame {
            self.originImage = cell.image()
            self.originFrame = collectionView.convert(frame, to: collectionView.superview)
        }
        self.performSegue(withIdentifier: "detailCharacterSegue", sender: indexPath.row)
    }
}

extension CharactersViewController: CharactersViewModelLoadable {
    func reloadElements() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}


