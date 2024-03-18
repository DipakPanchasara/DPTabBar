//
//  DPTabBar.swift
//
//
//  Created by Dipak Panchasara on 18/03/24.
//

import UIKit
public protocol DPTabBarDelegate: AnyObject {
    func tabBar(_ tabBar: DPTabBar, didSelectTabAt index: Int)
}

public class DPTabBar: UIView {
    
    //MARK:- Public Properties
    public var textColor: TextColor = TextColor(unSelected: UIColor.black, selected: UIColor.black)
    
    public var imageColor: ImageColor = ImageColor(unSelected: UIColor.black, selected: UIColor.white)
    public var defaultTitleFont: UIFont = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.semibold)
    
    
    open var tabBarTintColor: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    
    public var selectedTabImageSize: CGFloat = 60 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    open var shapeType: Shape = .full {
        didSet{
            setNeedsDisplay()
        }
    }
    public var selectedImage: UIImage? {
        didSet{
            self.innerView.image = selectedImage
            self.innerView.backgroundColor = UIColor.clear
            
            setNeedsDisplay()
        }
    }
    
    internal  var viewControllers = [UIViewController]() {
        didSet {
            guard !viewControllers.isEmpty else { return }
            
            DispatchQueue.main.async {
                self.drawTabs()
                self.didSelectTab(index: 0)
            }
        }
    }
    
    internal var isOffSetOn: Bool = true {
        didSet {
            self.cornerBackgroundView.isHidden = !isOffSetOn
            self.setNeedsDisplay()
        }
    }
    
    //MARK:- Views
    private lazy var stackView = UIStackViewFactory.createStackView(with: .horizontal, alignment: .center, distribution: .fillEqually, spacing: 0)
    
    private lazy var innerView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
        
    private lazy var cornerBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.maskedCorners = shapeType.maskCorenrs
        view.layer.masksToBounds = true
        view.clipsToBounds = false
        return view
    }()
    
    //MARK:- delegate
    
    weak var delegate: DPTabBarDelegate?
    
    //MARK:- Private properties
    
    private var selectedIndex: Int = 0
    private var previousSelectedIndex = 0
    
    //MARK:- initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setUp()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setupConstraints()
        cornerBackgroundView.backgroundColor = self.tabBarTintColor
        
        cornerBackgroundView.layer.cornerRadius = bounds.midY - shapeType.layoutMargins.last!/2
        cornerBackgroundView.layer.maskedCorners = shapeType.maskCorenrs
        
        //innerCircleView.backgroundColor = tabBarTintColor
        cornerBackgroundView.layoutIfNeeded()
        
        cornerBackgroundView.layer.shadowOffset = .zero
        cornerBackgroundView.layer.shadowOpacity = 0.18
        cornerBackgroundView.layer.shadowRadius = 10
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard let touchArea = touches.first?.location(in: self).x else {
            return
        }
        let index = Int(floor(touchArea / tabWidth))
        didSelectTab(index: index)
    }
}

//MARK:- set upview and constraints
private extension DPTabBar {
    func setUp() {
        setUpView()
        setupConstraints()
    }
    
    func setUpView() {
        addSubview(innerView)
        addSubview(stackView)
    }
    func setupConstraints() {
        
        innerView.frame = CGRect(origin: CGPoint(x: 0, y: -((selectedTabImageSize/2) - 4) ), size: CGSize(width: selectedTabImageSize, height: selectedTabImageSize))
        cornerBackgroundView.removeFromSuperview()
        insertSubview(cornerBackgroundView, at: 0)
        cornerBackgroundView
            .alignEdgesWithSuperview([.left, .right, .top, .bottom], constants:shapeType.layoutMargins)
        stackView
            .alignAllEdgesWithSuperview()
    }
    
}

//MARK:- Add DPTabBarItem in tabBar
extension DPTabBar {
    private func drawTabs() {
        for (_ , vc) in viewControllers.enumerated() {
            let barView = DPTabBarItem(tabBarItem: vc.tabBarItem, textColor: self.textColor, imageColor: self.imageColor)
            barView.defaultTitleFont = defaultTitleFont
            barView
                .height(constant: stackView.bounds.maxY)
            
            self.stackView.addArrangedSubview(barView)
        }
    }
}

//MARK:- Touch Handling

extension DPTabBar {
    
    private  var tabWidth: CGFloat {
        return (UIScreen.main.bounds.width / CGFloat(viewControllers.count))
    }
    
    private var circleTransition: (startX:CGFloat, endX: CGFloat) {
        let startPoint_X = CGFloat(previousSelectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        let endPoint_X = CGFloat(selectedIndex) * CGFloat(tabWidth) - (tabWidth * 0.5)
        return (startPoint_X,endPoint_X)
    }
    
    func didSelectTab(index: Int) {
        delegate?.tabBar(self, didSelectTabAt: index)
        if index + 1 == selectedIndex {return}
        
        previousSelectedIndex = selectedIndex
        selectedIndex  = index + 1
        
//        self.backgroundColor =  isOffSetOn ? colors[index] : tabBarTintColor
        
        innerView.layer.animateShapeSpring(from: circleTransition.startX, endX: circleTransition.endX)
        animateTabItem(index: index)
    }
}
//MARK:- Animation shape
private extension DPTabBar {
    
    func animateTabItem(index: Int) {
        self.stackView.arrangedSubviews.enumerated().forEach {
            guard let tabView = $1 as? DPTabBarItem else { return }
            ($0 == index ? tabView.animateTabSelected : tabView.animateTabDeSelect)()
        }
    }
}

