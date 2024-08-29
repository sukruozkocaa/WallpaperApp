//
//  ZoomTransitioner.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit

// MARK: - ZoomTransitioner
final class ZoomTransitioner : NSObject {
    
    // MARK: - Views
    weak var attachVC : UIViewController?
    var transitOriginalView : UIView? = nil

    // MARK: - Variables
    var swipeBackDisabled : Bool = false
    private(set) var swipBackTransitioning: UIPercentDrivenInteractiveTransition? = nil
    
    // MARK: - convenience init
    convenience init(vc : UIViewController) {
        self.init()
        attachVC = vc
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension ZoomTransitioner: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let trans = ZoomAnimatedTransitioning()
        trans.transitOriginalView = self.transitOriginalView;
        trans.isPresentation = true;
        return trans;
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let trans = ZoomAnimatedTransitioning()
        trans.transitOriginalView = self.transitOriginalView;
        trans.isPresentation = false;
        return trans;
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.swipBackTransitioning
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        weak var ws = self
        let controller = SwipeBackPresentationController.init(presentedViewController: presented, presenting: presenting) { (containerView) in
            guard let sws = ws else {return}
            let ges = UIScreenEdgePanGestureRecognizer.init(target: sws, action: #selector(sws.edgePan(panGes:)))
            ges.edges = UIRectEdge.left
            containerView?.addGestureRecognizer(ges)
        }
        return controller
    }
}

extension ZoomTransitioner {
    
    @objc func edgePan(panGes : UIScreenEdgePanGestureRecognizer) {
        
        guard let atvc = self.attachVC else {return}
        guard let presentingvc = self.attachVC?.presentingViewController else {return}
        
        if let container = panGes.view {
            switch panGes.state {
            case .began:
                if (!self.swipeBackDisabled &&
                    nil == self.swipBackTransitioning &&
                    !atvc.isBeingPresented &&
                    !atvc.isBeingDismissed) {
                    self.swipBackTransitioning = UIPercentDrivenInteractiveTransition()
                    self.swipBackTransitioning?.completionCurve = .easeOut
                    presentingvc.dismiss(animated: true, completion: nil)
                }
                
            case .changed:
                let translation = panGes.translation(in: container)
                var width : CGFloat = container.bounds.width
                if (width <= 0) { width = 300 }
                let d = translation.x > 0 ? (translation.x / width) : 0
                self.swipBackTransitioning?.update(d)
                
            case .ended, .cancelled, .failed:
                if (nil != self.swipBackTransitioning) {
                    if (panGes.velocity(in: container).x > 0 || self.swipBackTransitioning!.percentComplete > 0.5) {
                        self.swipBackTransitioning?.finish()
                    } else {
                        self.swipBackTransitioning?.cancel()
                    }
                    self.swipBackTransitioning = nil
                }
                
            default:
                return
            }
        }
    }
}
