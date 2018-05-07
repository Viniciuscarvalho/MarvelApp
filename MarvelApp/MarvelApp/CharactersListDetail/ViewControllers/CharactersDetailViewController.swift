//
//  HeroesDetailViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 20/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

class CharactersDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteIcon: UIImageView!
    
    var viewModel: CharactersDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        loadFavorite()
    }
    
    @IBAction func didFavorite(_ sender: UIButton) {
        let character = viewModel.output["Character"]?.first as? Character
        save(character: character)
    }
    
    private func loadFavorite() {
        let character = viewModel.output["Character"]?.first as? Character
        
        guard let item = character else { return }
        let id = "F\(item.id)"
        
        if let status = UserDefaults.standard.value(forKey: id) as? Bool {
            if status {
                favoriteIcon.image = Assets.favoriteFull.image
            }
        }
    }
    
    private func setFavorite(status: Bool) {
        favoriteIcon.image = (status ? Assets.favoriteFull.image : Assets.favoriteEmpty.image)
    }
    
}

extension CharactersDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.output.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count: Int = viewModel.output.enumerated().filter({ index, _ in
            return index == section
        }).map({ $1 }).reduce(0, { (sumUntilNow, details) -> Int in
            sumUntilNow + details.value.count
        })
        
        return count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.output.enumerated().first(where: { index, _ in
            return index == section
        })?.element.key
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CharactersDetailCell.self), for: indexPath)
        
        if let characterDetailCell = cell as? CharactersDetailCell {
            let item = viewModel.output.enumerated().filter({ index, _ in
                return index == indexPath.section
            }).map { (index, element) in
                return element.value[indexPath.row]
            }.first
            
            if let item = item {
                characterDetailCell.populateCell(viewModel: item)
            }
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
