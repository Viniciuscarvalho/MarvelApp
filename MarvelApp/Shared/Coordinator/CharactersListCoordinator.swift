//
//  CharactersListCoordinator.swift
//  MarvelApp
//
//  Created by vinicius.marques on 22/03/2019.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import Foundation
import UIKit

class CharactersListCoordinator: CoordinatorProtocol {
    private let presenter: UINavigationController
    private var viewModel = CharactersViewModel()
    private var charactersViewController: CharactersViewController?
    
    init(presenter: UINavigationController, viewModel: CharactersViewModel) {
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func start() {
        let charactersViewController = CharactersViewController(viewModel: viewModel)
        charactersViewController.delegate = self
        viewModel.setup(loadableData: charactersViewController)
        charactersViewController.title = "Characters"
        presenter.pushViewController(charactersViewController, animated: true)
        self.charactersViewController = charactersViewController
    }
    
}

extension CharactersListCoordinator: CharactersViewControllerDelegate {
    func charactersViewControllerDidSelectHero(_ selectedHero: Character) {
        let viewModelDetail = CharactersDetailViewModel(character: selectedHero)
        let charactersDetailCoordinator = CharactersDetailCoordinator(presenter: presenter, characterDetailViewModel: viewModelDetail)
        charactersDetailCoordinator.start()
    }
    
}
