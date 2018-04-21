//
//  NotificationConstants.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 21/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import Foundation

enum NotificationConstants: String{
    case shouldLoadMovies
    case shouldHandleItemSelection
    case shouldChangeCurrentState
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.rawValue), object: nil)
    }
    
    func post(withDictionary dictionary: [String: Any]) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: self.rawValue), object: nil, userInfo: dictionary)
    }
    
    func observe(target: Any, selector: Selector){
        NotificationCenter.default.addObserver(target, selector: selector, name: NSNotification.Name(rawValue: self.rawValue), object: nil)
    }
}
