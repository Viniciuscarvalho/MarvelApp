//
//  HeroesDetailViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 20/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import Reusable

class CharactersDetailViewController: UIViewController, UITableViewDelegate {
    
    private var charactersDetailView = CharactersDetailView()
    
    let viewModelDetail: CharactersDetailViewModel
    let favoriteRepository: FavoritedCharacterRepository
    
    init(viewModel: CharactersDetailViewModel, repository: FavoritedCharacterRepository) {
        self.favoriteRepository = repository
        self.viewModelDetail = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        charactersDetailView.setup(character: viewModelDetail.character, isFavorited: favoriteRepository.isFavorited(character: viewModelDetail.character))
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func loadView() {
        self.view = charactersDetailView
    }
    
    func setup() {
        charactersDetailView.saveDelegate = self
        charactersDetailView.tableView.delegate = self
        charactersDetailView.tableView.dataSource = self
        charactersDetailView.tableView.register(cellType: CharactersDetailCell.self)
    }
  
}

extension CharactersDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelDetail.output.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count: Int = viewModelDetail.output.enumerated().filter({ index, _ in
            return index == section
        }).map({ $1 }).reduce(0, { (sumUntilNow, details) -> Int in
            sumUntilNow + details.value.count
        })
        
        return count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModelDetail.output.enumerated().first(where: { index, _ in
            return index == section
        })?.element.key
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: CharactersDetailCell = tableView.dequeueReusableCell(for: indexPath)
        
        let item = viewModelDetail.output.enumerated().filter({ index, _ in
            return index == indexPath.section
        }).map { (index, element) in
            return element.value[indexPath.row]
            }.first
        
        if let item = item {
            cell.populateCell(viewModel: item)
        }
        
        return cell
    }
}

extension CharactersDetailViewController: FavoriteDelegate {
    func save(character: Character?) {
        guard let item = character else { return }
        favoriteRepository.toggleFavorite(character: item)
    }
    
}
