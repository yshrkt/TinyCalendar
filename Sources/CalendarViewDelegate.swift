//
//  CalendarViewDelegate.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/26.
//
//

import UIKit

public protocol CalendarViewDelegate: class {
    func calendarView(_ calendarView: CalendarView, willUpdateCellsFor dates: [CalendarDate])
    func calendarView(_ calendarView: CalendarView, didUpdateCellsFor dates: [CalendarDate])
    
    func calendarView(_ calendarView: CalendarView, willUpdateCellAt date: CalendarDate) -> CalendarDate?
    func calendarView(_ calendarView: CalendarView, didUpdateCellAt date: CalendarDate)
    
    func calendarView(_ calendarView: CalendarView, willSelectCellAt date: CalendarDate) -> CalendarDate?
    func calendarView(_ calendarView: CalendarView, didSelectCellAt date: CalendarDate)
    
    func calendarView(_ calendarView: CalendarView, willDeselectCellAt date: CalendarDate) -> CalendarDate?
    func calendarView(_ calendarView: CalendarView, didDeselectCellAt date: CalendarDate)
    
    func calendarView(_ calendarView: CalendarView, configureHeaderCellAt weekday: Weekday)
    
    func heightForHeaderView(in calendarView: CalendarView) -> CGFloat
}

public extension CalendarViewDelegate {
    func calendarView(_ calendarView: CalendarView, willUpdateCellsFor dates: [CalendarDate]) {
        
    }
    
    func calendarView(_ calendarView: CalendarView, didUpdateCellsFor dates: [CalendarDate]) {
        
    }
    
    func calendarView(_ calendarView: CalendarView, willUpdateCellAt date: CalendarDate) -> CalendarDate? {
        return date
    }
    func calendarView(_ calendarView: CalendarView, didUpdateCellAt date: CalendarDate) {
    
    }
    
    func calendarView(_ calendarView: CalendarView, willSelectCellAt date: CalendarDate) -> CalendarDate? {
        return date
    }
    func calendarView(_ calendarView: CalendarView, didSelectCellAt date: CalendarDate) {
    
    }
    
    func calendarView(_ calendarView: CalendarView, willDeselectCellAt date: CalendarDate) -> CalendarDate? {
        return date
    }
    func calendarView(_ calendarView: CalendarView, didDeselectCellAt date: CalendarDate) {
    
    }
    
    func calendarView(_ calendarView: CalendarView, configureHeaderCellAt weekday: Weekday) {
    
    }
    
    func heightForHeaderView(in calendarView: CalendarView) -> CGFloat {
        return 28.0
    }
}
