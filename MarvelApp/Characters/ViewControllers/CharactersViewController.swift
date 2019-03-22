//
//  HeroesViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import Reusable

final class CharactersViewController: UIViewController {
    
    fileprivate var originFrame: CGRect?
    fileprivate var originImage: UIImage?
    
    var currentPage = 0
       
    private var viewModel: CharactersViewModelProtocol
    
    private var charactersCollectionView = CharactersCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        setup()
    }
    
    init(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.addSubview(charactersCollectionView)
        
        charactersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        charactersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        charactersCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        charactersCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        charactersCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        reloadElements()
    }
    
    func setup() {
        self.viewModel.fetchCharacters()
        self.charactersCollectionView.collectionView.delegate = self
        self.charactersCollectionView.collectionView.dataSource = self
        self.charactersCollectionView.searchBar.delegate = self
        charactersCollectionView.collectionView.register(cellType: CharactersCollectionViewCell.self)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard segue.identifier == "detailCharacterSegue" else { return }
//        if let index = sender as? Int {
//            guard let destination = segue.destination as? CharactersDetailViewController else { return }
//            guard let item = self.viewModel?.character(index: index) else { return }
//            destination.viewModel = CharactersDetailViewModel(character: item)
//        } else if let item = sender as? Character {
//            guard let destination = segue.destination as? CharactersDetailViewController else { return }
//            destination.viewModel = CharactersDetailViewModel(character: item)
//        }
//    }
    
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        let total = self.viewModel.countCharacters()
        
        return total
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharactersCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)

        if let character = self.viewModel.character(index: indexPath.row) {
            cell.setup(character: character, viewModel: self.viewModel)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.countCharacters() - indexPath.row < 4 {
            nextPage(index: currentPage)
        }
    }
    
    fileprivate func nextPage(index: Int) {
        self.viewModel.fetchCharacters()
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
//        self.performSegue(withIdentifier: "detailCharacterSegue", sender: indexPath.row)
    }
}

extension CharactersViewController: CharactersViewModelLoadable {
    func reloadElements() {
        DispatchQueue.main.async {
            self.charactersCollectionView.collectionView.reloadData()
        }
    }
}

extension CharactersViewController: UISearchBarDelegate {
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.viewModel.searchString = searchBar.text
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
        self.viewModel.searchString = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

