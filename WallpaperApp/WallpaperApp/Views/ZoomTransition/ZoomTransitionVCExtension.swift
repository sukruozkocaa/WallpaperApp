//
//  ZoomTransitionVCExtension.swift
//  WallpaperApp
//
//  Created by Şükrü on 22.08.2024.
//

import UIKit
extension UIViewController {
    
    //set the  presented viewController,
    //originalView: Which being tap in presenting view
    public func setZoomTransition(originalView : UIView) {
        self.modalPresentationStyle = .custom
        self.modalPresentationCapturesStatusBarAppearance = true
        let transitioner = ZoomTransitioner.init(vc: self)
        transitioner.transitOriginalView = originalView
        self.transitioner = transitioner
        self.transitioningDelegate = self.transitioner
    }
    
    public var swipeBackDisabled : Bool {
        get {
            if let trans = self.transitioner {
                return trans.swipeBackDisabled
            } else {
                return false
            }
        }
        
        set {
            self.transitioner?.swipeBackDisabled = newValue
        }
    }
    
    
    private struct AssociatedKey {
        static var ZoomTransitioner = "zoomTransitioner"
    }
    
    private var transitioner : ZoomTransitioner?{
        get {
            if let transitioner = objc_getAssociatedObject(self, &AssociatedKey.ZoomTransitioner) as? ZoomTransitioner {
                return transitioner
            } else {
                return nil
            }
        }
        
        set {
            objc_setAssociatedObject(self, &AssociatedKey.ZoomTransitioner, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
