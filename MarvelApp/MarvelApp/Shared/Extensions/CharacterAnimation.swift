//
//  CharacterAnimation.swift
//  MarvelApp
//
//  Created by Vinicius Carvalho Marques on 24/04/2018.
//  Copyright © 2018 Vinicius Carvalho. All rights reserved.
//

import UIKit

class CharacterAnimation : NSObject, UIViewControllerAnimatedTransitioning {
    var duration = TimeInterval(UINavigationControllerHideShowBarDuration)
    var originFrame : CGRect
    var image : UIImage
    var isPresenting : Bool
    
    public let CustomAnimatorTag = 42
    
    init(originFrame : CGRect, image : UIImage, isShow : Bool = false) {
        self.originFrame = originFrame
        self.image = image
        self.isPresenting = isShow
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        
        guard let photo = detailView.viewWithTag(CustomAnimatorTag) as? UIImageView else { return }
        photo.image = image
        photo.alpha = 0
        
        let transitionImageView = UIImageView(frame: isPresenting ? originFrame : photo.frame)
        transitionImageView.image = image
        
        container.addSubview(transitionImageView)
        
        toView.frame = isPresenting ?  CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        UIView.animate(withDuration: duration, animations: {
            transitionImageView.frame = self.isPresenting ? photo.frame : self.originFrame
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            transitionImageView.removeFromSuperview()
            photo.alpha = 1
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}

