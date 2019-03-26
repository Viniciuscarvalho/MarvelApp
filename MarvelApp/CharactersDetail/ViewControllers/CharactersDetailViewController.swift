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
    
    init(viewModel: CharactersDetailViewModel) {
        self.viewModelDetail = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadFavorite()
        charactersDetailView.setup(character: viewModelDetail.character)
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    override func loadView() {
        self.view = charactersDetailView
    }
    
    func setup() {
        charactersDetailView.tableView.delegate = self
        charactersDetailView.tableView.dataSource = self
        charactersDetailView.tableView.register(cellType: CharactersDetailCell.self)
    }
    
    func didFavorite() {
        let character = viewModelDetail.output["Character"]?.first as? Character
        save(character: character)
    }
    
    private func loadFavorite() {
        let character = viewModelDetail.output["Character"]?.first as? Character
        
        guard let item = character else { return }
        let id = "F\(item.id)"
        
        if let status = UserDefaults.standard.value(forKey: id) as? Bool {
            if status {
                charactersDetailView.favorite.setBackgroundImage(Assets.favoriteFull.image
                    , for: .normal)
            }
        }
    }
    
    private func setFavorite(status: Bool) {
        if status == true {
            charactersDetailView.favorite.setBackgroundImage(Assets.favoriteFull.image, for: .normal)
        } else {
            charactersDetailView.favorite.setBackgroundImage(Assets.favoriteEmpty.image, for: .normal)
        }
    }
    
}

extension CharactersDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModelDetail.output.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
        guard let character = character else { return }
        let id = "F\(character.id)"
        
        if let status = UserDefaults.standard.value(forKey: id) as? Bool {
            setFavorite(status: !status)
            UserDefaults.standard.removeObject(forKey: id)
        } else {
            setFavorite(status: true)
            UserDefaults.standard.set(true, forKey: id)
        }
        
        UserDefaults.standard.synchronize()
    }
    
}
