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
    private var applicationCoordinator: ApplicationCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let applicationCoordinator = ApplicationCoordinator(window: window)
        self.applicationCoordinator = applicationCoordinator
        self.window = window
  
        applicationCoordinator.start()
        
        return true
    }

}

