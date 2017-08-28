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
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.year, .month, .day, .weekday], from: date)
        guard let year = dateComponents.year,
            let month = dateComponents.month,
            let day = dateComponents.day,
            let wd = dateComponents.weekday,
            let weekday = Weekday(rawValue: wd)else {
                return nil
        }
        return CalendarDate(year: year, month: month, day: day, weekday: weekday)
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
