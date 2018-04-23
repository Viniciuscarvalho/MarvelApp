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
        self.registerCell()
        self.currentStates = .loading
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
    
    fileprivate func setupDelegateAndDataSource() {
        self.heroesDataSource = HeroesDataSource(with: [])
    }
    
}

extension HeroesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
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
        self.heroesDataSource?.isSearching = false
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
}

extension HeroesViewController: CharactersViewModelLoadable {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

