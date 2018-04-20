//
//  NibLoadableProtocol.swift
//  MarvelApp
//
//  Created by Vinicius Marques on 20/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

public protocol NibLoadableProtocol: NSObjectProtocol {
    func loadNib() -> UIView
    func nibName() -> String
    var nibContainerView: UIView { get }
}

extension NibLoadableProtocol {
    
    public func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.nibName(), bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil)[0] as! UIView
    }
    
    fileprivate func setupNib() {
        let view = self.loadNib()
        self.nibContainerView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        let bindings = ["view": view]
        self.nibContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
                                                                            options:[], metrics: nil, views: bindings))
        self.nibContainerView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
                                                                            options:[], metrics: nil, views: bindings))
    }
}

extension UIView {
    public var nibContainerView: UIView {
        return self
    }
    
    open func nibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
}

open class NibLoadableView: UIView, NibLoadableProtocol {
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.setupNib()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupNib()
    }
}
