//
//  LoadingView.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 20/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit
import CoreGraphics

class LoadingView: NibLoadableView {
    
    func start() {
        update(alpha: CGFloat.Alpha.showing) { [weak self] in
            self?.isHidden = false
        }
    }
    
    func stop() {
        update(alpha: CGFloat.Alpha.hiding) { [weak self] in
            self?.isHidden = true
        }
    }
    
    private func update(alpha: CGFloat, completion: @escaping(() -> Void)) {
        UIView.animate(withDuration: TimeInterval.animationSpeed, animations: { [weak self] in
            self?.alpha = CGFloat(alpha)
        }) { completed in
            guard completed else { return }
            completion()
        }
    }
    
}

extension CGFloat {
    struct Alpha {
        static let hiding: CGFloat = 0
        static let showing: CGFloat = 1
    }
}

extension TimeInterval {
    static let animationSpeed: Double = 0.3
}
