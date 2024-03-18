//
//  DPTabBarItem.swift
//
//
//  Created by Dipak Panchasara on 18/03/24.
//

import Foundation
import UIKit

public struct TextColor {
    let unSelected: UIColor
    let selected: UIColor
}

public struct ImageColor {
    let unSelected: UIColor
    let selected: UIColor
}

public class DPTabBarItem: UIView {
    
    //MARK:- Properties
    private let image: UIImage
    private let title: String
    
    private var textColor: TextColor {
        didSet{
            titleLabel.textColor = textColor.unSelected
        }
    }
    private var imageColor: ImageColor {
        didSet{
            imageView.tintColor = imageColor.unSelected
        }
    }
    public var defaultTitleFont: UIFont = UIFont.systemFont(ofSize: 10, weight: UIFont.Weight.semibold)
    
    
    
    private var imageCenterYConstraint : NSLayoutConstraint?
    private var titleCenterYConstraint : NSLayoutConstraint?
    
    open var animationDuration: Double = 0.5
    open var badgeColor: UIColor?
    open var badgeValue: String?
    var imageSize: CGFloat = 25
    
    //MARK:- Views
    private lazy var titleLabel = UILabelFactory.createUILabel(with: textColor.unSelected,
                                                               font: defaultTitleFont,
                                                               alignment: .center,
                                                               text: self.title)
    
    private lazy var imageView = UIImageViewFactory.createImageView(mode: .scaleAspectFit,
                                                                    image: image,
                                                                    tintColor: imageColor.unSelected)
    
    //MARK:- initialiser
    
    init(tabBarItem item: UITabBarItem, textColor: TextColor, imageColor: ImageColor) {
        
        guard let selecteImage = item.image else {
            fatalError("You should set image to all view controllers")
        }
        
        self.image = selecteImage.withRenderingMode(.alwaysTemplate)
        self.title = item.title ?? ""
        self.textColor = textColor
        self.imageColor = imageColor
        super.init(frame: .zero)
        self.clipsToBounds = false
        self.titleLabel.clipsToBounds = false
        
        setup()
    }
    public override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.center = CGPoint(x: self.bounds.width / 2, y: (self.bounds.height / 2) + 4)
        if isBottom == false {
            titleLabel.center = CGPoint(x: self.bounds.width / 2, y: (self.bounds.height / 2) + 10)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK:- setup View
private extension DPTabBarItem {
    func setup() {
        setupViews()
        setupConstraints()
    }
    func setupViews() {
        addSubview(imageView)
        addSubview(titleLabel)
        
//        titleLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
//        titleLabel.layer.shadowOpacity = 0.2
//        titleLabel.layer.shadowRadius = 1
//        titleLabel.minimumScaleFactor = 0.5
        
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = false
    }
    func setupConstraints() {
        
        imageView
            .width(constant: imageSize)
            .height(constant: imageSize)
            .centerHorizontallyInSuperview()
        
        imageCenterYConstraint = imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        imageCenterYConstraint?.isActive = true
        self.titleLabel.alpha = 1
        titleLabel.alignEdges([DPLayoutEdge.left,.right], withView: self)
        
    }
}

//MARK:- Select / DeSelect item
internal extension DPTabBarItem {
    func animateTabSelected() {
        imageCenterYConstraint?.constant = isBottom == false ? -30 : -40
        imageView.tintColor = self.imageColor.selected
        self.titleLabel.textColor = self.textColor.selected
        UIView.animate(withDuration: animationDuration) {
            self.layoutIfNeeded()
        }
    }
    
    func animateTabDeSelect() {
        imageCenterYConstraint?.constant = isBottom == false ? -14 : -24
        imageView.tintColor = self.imageColor.unSelected
        self.titleLabel.textColor = self.textColor.unSelected
        UIView.animate(withDuration: animationDuration, animations: {
            self.layoutIfNeeded()
        }) { _ in
            self.layoutIfNeeded()
        }
    }
}
