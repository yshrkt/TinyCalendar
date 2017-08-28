//
//  LineAxis.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/26.
//
//

import Foundation

public struct LineAxis: OptionSet {
    public let rawValue: UInt8
    public init(rawValue: UInt8) { self.rawValue = rawValue }
    
    public static let horizontal = LineAxis(rawValue: 0x01)
    public static let vertical = LineAxis(rawValue: 0x01 << 1)
    
    static let both: LineAxis = [.horizontal, .vertical]
    
}
