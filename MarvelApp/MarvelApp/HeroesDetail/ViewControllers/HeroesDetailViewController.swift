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
    var viewModel: CharactersDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
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
