//
//  HeroesViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 19/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation
import UIKit

enum ViewStates {
    case loading
    case showCharacters
    case errorLoadCharacters
    case noShowSearchResults
}

class HeroesViewController: UIViewController {
    
    var loadingView: LoadingView = LoadingView()
    
    @IBOutlet weak var collectionView: UICollectionView!
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
        self.title = "Characters"
        self.setupNotification()
        self.setupDelegateAndDataSource()
        self.viewModel = CharactersViewModel(loadableData: self)
        self.viewModel?.loadData()
        self.navigationController?.delegate = self
        self.currentStates = .loading
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.heroesDataSource?.reloadCollection()
    }
    
    fileprivate func setupDelegateAndDataSource() {
        self.heroesDataSource = HeroesDataSource(with: [], collectionView: collectionView)
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

