//
//  HeroesDetailViewController.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 20/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

class HeroesDetailViewController: UIViewController {
    
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
        
        guard let item = character, let name = item.name else { return }
        
        if let status = UserDefaults.standard.value(forKey: name) as? Bool {
            if status {
                favoriteIcon.image = UIImage(named: "favorite_full_icon")
            }
        }
    }
    
    private func setFavorite(status: Bool) {
        favoriteIcon.image = (status ? UIImage(named: "favorite_full_icon") : UIImage(named: "favorite_empty_icon"))
    }
    
}

extension HeroesDetailViewController: UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroesDetailCell.self), for: indexPath)
        
        if let characterDetailCell = cell as? HeroesDetailCell {
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

extension HeroesDetailViewController: FavoriteDelegate {
    
    func save(character: Character?) {
        guard let character = character, let name = character.name else { return }
        
        if let status = UserDefaults.standard.value(forKey: name) as? Bool {
            setFavorite(status: !status)
            UserDefaults.standard.set(!status, forKey: name)
        } else {
            setFavorite(status: true)
            UserDefaults.standard.set(true, forKey: name)
        }
        
        UserDefaults.standard.synchronize()
    }
    
}
