//
//  Coordinator.swift
//  MarvelApp
//
//  Created by vinicius.marques on 15/03/2019.
//  Copyright © 2019 Vinicius Carvalho. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol {
    func start()
    var navigationController: UINavigationController { get }
}

class Coordinator: CoordinatorProtocol {
    let navigationController: UINavigationController
    
    let viewModel = CharactersInteractor()
    
    func start() {
        let charactersViewController = CharactersViewController(viewModel: viewModel)
        viewModel.setup(loadableData: charactersViewController)
        navigationController.pushViewController(charactersViewController, animated: false)
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
