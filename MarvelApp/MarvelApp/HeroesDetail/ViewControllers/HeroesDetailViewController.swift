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
    var viewModel: CharactersDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
}

extension HeroesDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.count() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = viewModel?.item(index: indexPath.row) else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: item.cellID())
        item.populateCell(cell)
        return cell!
    }
}
