//
//  HeroesViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

enum ViewStates {
    case loading
    case showCharacters
    case errorLoadCharacters
    case noShowSearchResults
}

final class HeroesViewController: UIViewController {
    
    var loadingView: LoadingView = LoadingView()
    
    @IBOutlet private var collectionView: UICollectionView!
    var heroesDataSource: HeroesDataSource?
    var heroesDetailDataSource: HeroesDetailDataSource?
    fileprivate var viewModel: CharactersViewModelProtocol?
    
    var currentStates: ViewStates = .loading {
        didSet {
            switch currentStates {
            case .loading:
                self.loadingView.start()
            case .showCharacters:
                self.loadingView.stop()
            case .errorLoadCharacters:
                self.loadingView.stop()
            case .noShowSearchResults:
                self.loadingView.stop()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Characters"
        self.setupNotification()
        self.setupDelegateAndDataSource()
        self.viewModel = CharactersViewModel(loadableData: self)
        self.viewModel?.loadData()
        self.navigationController?.delegate = self
        self.currentStates = .loading
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailCharacterSegue" else { return }
        if let index = sender as? Int {
            guard let destination = segue.destination as? HeroesDetailViewController else { return }
            guard let item = self.viewModel?.character(index: index) else { return }
            destination.viewModel = CharactersDetailViewModel(item: item)
        } else if let item = sender as? Character {
            guard let destination = segue.destination as? HeroesDetailViewController else { return }
            destination.viewModel = CharactersDetailViewModel(item: item)
        }
    }
    
    fileprivate func setupDelegateAndDataSource() {
        self.heroesDataSource = HeroesDataSource(with: [])
    }
    
    fileprivate func setupNotification() {
        NotificationConstants.shouldLoadMovies.observe(target: self, selector: #selector(loadMovies))
        NotificationConstants.shouldHandleItemSelection.observe(target: self, selector: #selector(handleItemSelection))
        NotificationConstants.shouldChangeCurrentState.observe(target: self, selector: #selector(changeCurrenteState))
    }
    
    @objc func handleItemSelection() {
        if let characters = self.heroesDataSource?.getSelectedCharacters(),
            let dataSource = self.heroesDetailDataSource {
            //dataSource.character = characters
           //CRIAR SEGUE PARA DETAIL
        }
    }
    
    @objc func changeCurrenteState() {
        if self.heroesDataSource?.isSearching == true{
            self.currentStates = .noShowSearchResults
        } else {
            self.currentStates = .showCharacters
        }
    }
    
}

extension HeroesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.searchString = searchText
    }
}

extension HeroesViewController: CharactersViewModelLoadable {
    func reloadData() {
        DispatchQueue.main.async {
            self.collection.reloadData()
        }
    }
    
//    func reloadFavorite() {
//        guard let favorite = self.viewModel?.favoriteCharacter else {
//            self.favoriteView.reset()
//            return
//        }
//        DispatchQueue.main.async {
//            self.collection.visibleCells.forEach { item in
//                if let cell = item as? CharactersCollectionCell {
//                    if cell.getID() != favorite.id {
//                        cell.cleanFavorite()
//                    }
//                }
//            }
//            self.favoriteView.configureFavorite(favorite) { item in
//                self.originImage = self.favoriteView.favoriteImage.image
//                self.originFrame =  self.favoriteView.favoriteImage.frame
//
//                self.performSegue(withIdentifier: "detailCharacterSegue", sender: item)
//            }
//        }
//    }
}

