//
//  CharactersDetailCoordinator.swift
//  MarvelApp
//
//  Created by vinicius.marques on 22/03/2019.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import UIKit

class CharactersDetailCoordinator: CoordinatorProtocol {
    private var presenter: UINavigationController
    private var characterDetailViewModel: CharactersDetailViewModel
    private var charactersDetailViewController: CharactersDetailViewController?
    
    init(presenter: UINavigationController, characterDetailViewModel: CharactersDetailViewModel) {
        self.presenter = presenter
        self.characterDetailViewModel = characterDetailViewModel
    }
    
    func start() {
        let charactersDetailViewController = CharactersDetailViewController(viewModel: characterDetailViewModel)
        presenter.pushViewController(charactersDetailViewController, animated: true)
        self.charactersDetailViewController = charactersDetailViewController
    }
    
}
