//
//  CalendarViewDelegate.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/26.
//
//

import UIKit

public protocol CalendarViewDelegate: class {
    func calendarView(_ calendarView: CalendarView, willUpdateCellAtDate date: CalendarDate)
    func calendarView(_ calendarView: CalendarView, didUpdateCellAtDate date: CalendarDate)
    
    func calendarView(_ calendarView: CalendarView, willSelectCellAtDate date: CalendarDate)
    func calendarView(_ calendarView: CalendarView, didSelectCellAtDate date: CalendarDate)
    
    func calendarView(_ calendarView: CalendarView, willDeselectCellAtDate date: CalendarDate)
    func calendarView(_ calendarView: CalendarView, didDeselectCellAtDate date: CalendarDate)
    
    func calendarView(_ calendarView: CalendarView, configureHeaderCellAtWeekday weekday: Weekday)
    
    func heightForHeaderView(in calendarView: CalendarView) -> CGFloat
}
