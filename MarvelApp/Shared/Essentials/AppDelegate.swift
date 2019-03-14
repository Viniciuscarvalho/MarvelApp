//
//  AppDelegate.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 18/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let root = CharactersViewController()
        let controller = UINavigationController(rootViewController: root)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        return true
    }

}

