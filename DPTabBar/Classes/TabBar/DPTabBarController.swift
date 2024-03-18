//
//  DPTabBarController.swift
//
//
//  Created by Dipak Panchasara on 18/03/24.
//

import Foundation
import UIKit

internal var deviceSize = UIScreen.main.fixedCoordinateSpace.bounds
internal var isBottom: Bool {
    if #available(iOS 13.0, *), let bottom = UIApplication.shared.windows.first?.safeAreaInsets.bottom, bottom > 0 {
        return true
    }
    return false
}

public protocol DPTabBarControllerDelegate: NSObjectProtocol {
    func tabBarController(_ tabBarController: DPTabBarController, didSelect viewController: UIViewController)
}

open class DPTabBarController: UIViewController {
    
    //MARK:- Properties
    weak open var delegate: DPTabBarControllerDelegate?
    var isProfileShow: Bool = false
    public var previosuSelected: Int = -1
    public var selectedIndex: Int = -1 {
        didSet {
            tabBar.didSelectTab(index: selectedIndex)
        }
    }
    
    public var isRoundedOffsetOn:Bool = true {
        didSet { tabBar.isOffSetOn = isRoundedOffsetOn }
    }
    private var selectedVC: UIViewController!
    public var viewControllers = [UIViewController]() {
        didSet { tabBar.viewControllers = viewControllers }
    }
    public var tabBarHeight: CGFloat =  {
        return isBottom ? 80 : 60
    }()
    
    //MARK:- Views
    public lazy var tabBar: DPTabBar = {
        let tabBar = DPTabBar()
        tabBar.delegate = self
        tabBar.translatesAutoresizingMaskIntoConstraints = false
        return tabBar
    }()
    
    private lazy var stack = UIStackViewFactory.createStackView(with: .vertical, alignment: .fill, distribution: .fill, arrangedSubviews: [containerView,tabBar])
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    //MARK:- Lifecycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(stack)
    }
    
    open override func viewDidLayoutSubviews() {
        self.drawConstraint()
    }
    
    private func drawConstraint() {
        tabBar
            .height(constant: tabBarHeight)
        
        stack
            .alignAllEdgesWithSuperview()
    }
    
}
extension DPTabBarController: DPTabBarDelegate {
    public func tabBar(_ tabBar: DPTabBar, didSelectTabAt index: Int) {
        delegate?.tabBarController(self, didSelect: self)
    }
    
    func removeVC(vc: UIViewController) {
        vc.willMove(toParentViewController: nil)
        vc.view.removeFromSuperview()
        vc.removeFromParentViewController()
    }
    
    func addVC(vc: UIViewController) {
        delegate?.tabBarController(self, didSelect: vc)
        addChildViewController(vc)
        vc.view.frame = containerView.bounds
        containerView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)
    }
}
