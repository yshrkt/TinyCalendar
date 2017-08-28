//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport
import TinyCalendar

let calendarView = CalendarView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
calendarView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
calendarView.outerlineStyle = .custom(color: .black, width: 4.0)
calendarView.separatorStyle = .custom(color: .black, width: 1.0)
calendarView.headerSeparatorStyle = .custom(color: .black, width: 4.0)
calendarView.configure()
calendarView.select(at: CalendarDate.today()!, animated: false)
calendarView.update(year: 2017, month: 9)

PlaygroundPage.current.liveView = calendarView
