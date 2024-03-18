//
//  DPLayoutAttributes.swift
//
//
//  Created by Dipak Panchasara on 18/03/24.
//

import UIKit

enum DPLayoutAxis {
    case vertical
    case horizontal
    case dimensions
}

public enum DPLayoutEdge {
    case left
    case right
    case top
    case bottom
    case bottomAvoidingKeyboard
    case safeAreaLeft
    case safeAreaRight
    case safeAreaTop
    case safeAreaBottom
    case safeAreaBottomAvoidingKeyboard
    case centerX
    case centerY
    case height
    case width
}

extension DPLayoutEdge {
    var axis: DPLayoutAxis {
        switch self {
        case .left, .right, .centerX, .safeAreaLeft, .safeAreaRight:
            return .horizontal
        case .bottom, .top, .centerY, .safeAreaTop, .safeAreaBottom, .bottomAvoidingKeyboard, .safeAreaBottomAvoidingKeyboard:
            return .vertical
        case .height, .width:
            return .dimensions
            
        }
    }
    
    var safeAreaEdge: DPLayoutEdge {
        switch self {
        case .left, .safeAreaLeft:
            return .safeAreaLeft
        case .top, .safeAreaTop:
            return .safeAreaTop
        case .right, .safeAreaRight:
            return .safeAreaRight
        case .bottom, .safeAreaBottom, .bottomAvoidingKeyboard, .safeAreaBottomAvoidingKeyboard:
            return .safeAreaBottom
        default:
            return .safeAreaLeft
        }
    }
}

public enum DPLayoutConstantModifier {
    case equalTo
    case lessThanOrEqualTo
    case greaterThanOrEqualTo
}

internal extension UIView {
    func horizontalAnchor(_ edge: DPLayoutEdge) -> NSLayoutXAxisAnchor {
        switch edge {
        case .left:
            return leadingAnchor
        case .right:
            return trailingAnchor
        case .centerX:
            return centerXAnchor
        case .safeAreaLeft:
            return safeAreaLayoutGuide.leadingAnchor
        case .safeAreaRight:
            return safeAreaLayoutGuide.trailingAnchor
        default:
            return leadingAnchor
        }
    }
    
    func verticalAnchor(_ edge: DPLayoutEdge) -> NSLayoutYAxisAnchor {
        switch edge {
        case .top:
            return topAnchor
        case .bottom, .bottomAvoidingKeyboard:
            return bottomAnchor
        case .centerY:
            return centerYAnchor
        case .safeAreaTop:
            return safeAreaLayoutGuide.topAnchor
        case .safeAreaBottom, .safeAreaBottomAvoidingKeyboard:
            return safeAreaLayoutGuide.bottomAnchor
        default:
            return topAnchor
        }
    }
    
    func dimensionAnchor(_ edge: DPLayoutEdge) -> NSLayoutDimension {
        switch edge {
        case .width:
            return widthAnchor
        case .height:
            return heightAnchor
        default:
            return widthAnchor
        }
    }
}
