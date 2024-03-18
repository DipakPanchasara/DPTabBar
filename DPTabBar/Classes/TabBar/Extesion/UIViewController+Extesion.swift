//
//
//  UIViewController+Extesion.swift
//
//
//  Created by Dipak Panchasara on 18/03/24.
//
import UIKit

private var associateKey: Void?
public extension UIViewController {
    var dPTabBarController : DPTabBarController? {
        get {
            if let parent = parent as? UINavigationController {
                if let controller = parent.parent as? DPTabBarController {
                    return controller
                }
            } else if let parent = parent as? DPTabBarController {
                return parent
            }
            return nil
        }
    }
    
    @IBInspectable  var hidesBottomSOBar: Bool {
        get {
            return (objc_getAssociatedObject(self, &associateKey) as? Bool) ?? false
        }
        set {
            objc_setAssociatedObject(self, &associateKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    @objc func newViewDidAppear(_ animated: Bool) {
	        self.newViewDidAppear(animated)
        self.dPTabBarController?.tabBar.isHidden = hidesBottomSOBar
    }
    
    static func setUpTabBar() {
        
        if self != UIViewController.self {
            return
        }
        let _: () = {
            let originalSelector = #selector(UIViewController.viewDidAppear(_:))
            let swizzledSelector = #selector(UIViewController.newViewDidAppear(_:))
            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)
            method_exchangeImplementations(originalMethod!, swizzledMethod!);
        }()
    }
}
