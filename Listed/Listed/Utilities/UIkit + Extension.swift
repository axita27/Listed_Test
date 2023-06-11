//
//  UIkit + Extension.swift
//  Listed
//
//  Created by Axita Dholariya on 09/06/23.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
}

class RoundedView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.size.height / 2.0
        clipsToBounds = true
    }
}

extension NSObject {
    class var listedClassName: String {
        return String(describing: self)
    }
}

extension UIImage{
    static var Click: UIImage {
        return UIImage(named: "Click")!
    }

    static var LocationPin: UIImage {
        return UIImage(named: "LocationPin")!
    }
    
    static var Source: UIImage {
        return UIImage(named: "Source")!
    }
}

extension UIColor{
    static var Border: UIColor {
        return UIColor(named: "Border")!
    }
    static var Header: UIColor {
        return UIColor(named: "Header")!
    }
    static var UnselectLinkText: UIColor {
        return UIColor(named: "UnselectLinkText")!
    }
    static var ChatBorder: UIColor {
        return UIColor(named: "ChatBorder")!
    }
    static var HelpBorder: UIColor {
        return UIColor(named: "HelpBorder")!
    }
    static var ChartG1: UIColor {
        return UIColor(named: "ChartG1")!
    }
    static var ChartG2: UIColor {
        return UIColor(named: "ChartG2")!
    }
}

