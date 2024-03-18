//
//  Shape.swift
//
//
//  Created by Dipak Panchasara on 18/03/24.
//

import Foundation
import UIKit

public enum Shape: Int {
    case full
    case upperRound
    case lowerRound
    case rounded
    case floating
    
    
    var maskCorenrs: CACornerMask {
        get {
            switch self {
            case .full:
                return  []
            case .upperRound:
                return [ .layerMaxXMinYCorner, .layerMinXMinYCorner ]
            case .lowerRound:
                return  [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            case .rounded, .floating:
                return [.layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner]
            }
            
        }
    }
    
    var layoutMargins: [CGFloat] {
        get {
            switch self {
            case .full, .upperRound:
                return [0,0,0,0]
            default:
                return [5,5,0,10]
            }
        }
    }
}
