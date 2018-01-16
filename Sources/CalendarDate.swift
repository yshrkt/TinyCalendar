//
//  CalendarDate.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/26.
//
//

import Foundation

public struct CalendarDate {
    public let year: Int
    public let month: Int
    public let day: Int
    public let weekday: Weekday
    
    public static func today() -> CalendarDate? {
        return CalendarDate(with: Date())
    }
    
    public init(year: Int, month: Int, day: Int, weekday: Weekday) {
        self.year = year
        self.month = month
        self.day = day
        self.weekday = weekday
    }
    
    public init?(with date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day,
            let wd = dateComponents.weekday,
            let weekday = Weekday(rawValue: wd)else {
                return nil
        }
        self.year = year
        self.month = month
        self.day = day
        self.weekday = weekday
    }
}

extension CalendarDate: Equatable, Hashable {
    public static func == (lhs: CalendarDate, rhs: CalendarDate) -> Bool {
        return lhs.year == rhs.year
            && lhs.month == rhs.month
            && lhs.day == rhs.day
            && lhs.weekday == rhs.weekday
    }
    
    public var hashValue: Int {
        return "\(year)/\(month)/\(day) \(weekday.rawValue)".hashValue
    }
}
