//
//  LineStyle.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/24.
//
//

import UIKit

public enum LineStyle {
    case none
    case separator
    case headerSeparator
    case outerline
    case custom(color: UIColor, width: CGFloat)
    
    var color: UIColor {
        switch self {
        case .none:
            return UIColor.clear
        case .separator:
            return UIColor.darkGray
        case .headerSeparator:
            return UIColor.darkGray
        case .outerline:
            return UIColor.darkGray
        case .custom(let color, _):
            return color
        }
    }
    
    var width: CGFloat {
        switch self {
        case .none:
            return 0.0
        case .separator:
            return 1.0 / UIScreen.main.scale
        case .headerSeparator:
            return 2.0 / UIScreen.main.scale
        case .outerline:
            return 4.0 / UIScreen.main.scale
        case .custom(_, let width):
            return width / UIScreen.main.scale
        }
    }
}
