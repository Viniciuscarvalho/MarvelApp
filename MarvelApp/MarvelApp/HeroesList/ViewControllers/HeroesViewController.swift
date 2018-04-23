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
        self.setupDelegateAndDataSource()
        self.viewModel = CharactersViewModel(loadableData: self)
        self.viewModel?.loadData()
        self.currentStates = .loading
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
    
    fileprivate func setupDelegateAndDataSource() {
        self.heroesDataSource = HeroesDataSource(with: [])
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
            self.collectionView.reloadData()
        }
    }
}

