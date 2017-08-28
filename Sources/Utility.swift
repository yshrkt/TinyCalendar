//
//  Utility.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/24.
//
//

import UIKit

extension Int {
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

extension CGFloat {
    var twice: CGFloat {
        return self * 2.0
    }
    
    var half: CGFloat {
        return self * 0.5
    }
}

extension CGPoint {
    func rounded(_ rule: FloatingPointRoundingRule) -> CGPoint {
        return CGPoint(x: self.x.rounded(rule), y: self.y.rounded(rule))
    }
}

extension CGSize {
    init(_ square: CGFloat) {
        self.width = square
        self.height = square
    }
    
    func rounded(_ rule: FloatingPointRoundingRule) -> CGSize {
        return CGSize(width: self.width.rounded(rule), height: self.height.rounded(rule))
    }
}

extension CGRect {
    var x: CGFloat {
        return self.origin.x
    }
    
    var y: CGFloat {
        return self.origin.y
    }
    
    func inset(by insets: UIEdgeInsets) -> CGRect {
        return CGRect(x: self.origin.x + insets.left,
                      y: self.origin.y + insets.top,
                      width: self.width - insets.dx,
                      height: self.height - insets.dy)
    }
}

extension UIEdgeInsets {
    init(_ all: CGFloat) {
        self.top = all
        self.bottom = all
        self.left = all
        self.right = all
    }
    
    init(topBottom dy: CGFloat, leftRight dx: CGFloat) {
        self.top = dy
        self.bottom = dy
        self.left = dx
        self.right = dx
    }
    
    init(topBottom dy: CGFloat, left: CGFloat, right: CGFloat) {
        self.top = dy
        self.bottom = dy
        self.left = left
        self.right = right
    }
    
    init(top: CGFloat, bottom: CGFloat, leftRight dx: CGFloat) {
        self.top = top
        self.bottom = bottom
        self.left = dx
        self.right = dx
    }
    
    init(top: CGFloat, others: CGFloat) {
        self.top = top
        self.bottom = others
        self.left = others
        self.right = others
    }
    
    init(bottom: CGFloat, others: CGFloat) {
        self.top = others
        self.bottom = bottom
        self.left = others
        self.right = others
    }
    
    init(left: CGFloat, others: CGFloat) {
        self.top = others
        self.bottom = others
        self.left = left
        self.right = others
    }
    
    init(right: CGFloat, others: CGFloat) {
        self.top = others
        self.bottom = others
        self.left = others
        self.right = right
    }
    
    var dx: CGFloat {
        return self.left + self.right
    }
    
    var dy: CGFloat {
        return self.top + self.bottom
    }
}
