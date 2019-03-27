//
//  HeroesViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import Reusable

protocol CharactersViewControllerDelegate: class {
    func charactersViewControllerDidSelectHero(_ selectedHero: Character)
}

final class CharactersViewController: UIViewController {
    
    var currentPage = 0
    
    var isLoadCharacters: Bool = false
    
    weak var delegate: CharactersViewControllerDelegate?
    private var viewModel: CharactersViewModel
    let favoriteRepository: FavoritedCharacterRepository
    
    private var charactersCollectionView = CharactersCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    init(viewModel: CharactersViewModel, repository: FavoritedCharacterRepository) {
        self.viewModel = viewModel
        self.favoriteRepository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view.addSubview(charactersCollectionView)
        
        //Mark: Add Search with safe area and navigation bar
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
    
}

extension CharactersViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.countCharacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CharactersCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
        
        cell.saveDelegate = self

        if let character = self.viewModel.character(index: indexPath.row) {
            cell.setup(character: character, isFavorited: favoriteRepository.isFavorited(character: character))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if viewModel.countCharacters() - indexPath.row < 4 {
            nextPage(index: currentPage)
        }
    }
    
    fileprivate func nextPage(index: Int) {
        //self.viewModel.fetchCharacters()
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

extension CharactersViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let character = self.viewModel.character(index: indexPath.row) {
            delegate?.charactersViewControllerDidSelectHero(character)
        }
    }
}

extension CharactersViewController: CharactersViewModelLoadable {
    func reloadElements() {
        DispatchQueue.main.async {
            self.charactersCollectionView.collectionView.reloadData()
        }
    }
}

extension CharactersViewController: FavoriteDelegate {
    func save(character: Character?) {
        guard let item = character else { return}
        favoriteRepository.toggleFavorite(character: item)
        charactersCollectionView.collectionView.reloadData()
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
