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
    var viewModel: CharactersDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

extension HeroesDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeroesDetailCell.self), for: indexPath)
        
        if let characterDetailCell = cell as? HeroesDetailCell {
            characterDetailCell.populateCell(viewModel: self.viewModel!)
        }
        return cell
    }
}
