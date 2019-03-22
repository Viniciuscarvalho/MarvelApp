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
}

class ApplicationCoordinator: CoordinatorProtocol {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let viewModel: CharactersViewModel
    let charactersListCoordinator: CharactersListCoordinator
    
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
        viewModel = CharactersViewModel()
        
        charactersListCoordinator = CharactersListCoordinator(presenter: rootViewController, viewModel: viewModel)
    }
    
    func start() {
        window.rootViewController = rootViewController
        charactersListCoordinator.start()
        window.makeKeyAndVisible()
    }
    
}
