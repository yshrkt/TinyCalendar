/*:
 
 # TinyCalendar Playground
 
 */

import UIKit
import PlaygroundSupport
import TinyCalendar

/*:
 
 ## Basic Usage
 
 ### Setup
 
 Setup canlendar view as bellow:
*/
let calendarView = CalendarView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
calendarView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
calendarView.configure()

//: ### Select a day
let today = CalendarDate.today()!
calendarView.select(at: today, animated: true)

//: ### Change year or month
let calendar = Calendar(identifier: .gregorian)
let nextMonthDate = calendar.date(byAdding: .month, value: 1, to: Date())!
let nextMonth = CalendarDate(with: nextMonthDate)!
calendarView.update(year: nextMonth.year, month: nextMonth.month)

/*:
 ## Customize calendar view
 
 ### Customize lines
 */
let exampleView = CalendarView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
exampleView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
exampleView.separatorAxis = .horizontal
exampleView.outerlineStyle = .none
exampleView.separatorStyle = .custom(color: .lightGray, width: 1.0)
exampleView.headerSeparatorStyle = .custom(color: .lightGray, width: 3.0)
exampleView.configure()
exampleView.select(at: today, animated: true)


//: ### Customize cells
//: You can create custom cell just like UITableViewCell's cell.

//: #### Example 1
class Example1HeaderCell: CalendarHeaderViewCell {
    override func configure(with weekday: Weekday) {
        super.configure(with: weekday)
        self.weekdayLabel.font = UIFont.systemFont(ofSize: 16)
        switch weekday {
        case .sunday:
            self.weekdayLabel.textColor = #colorLiteral(red: 0.951656878, green: 0.500697732, blue: 0.4544605613, alpha: 1)
        case .saturday:
            self.weekdayLabel.textColor = #colorLiteral(red: 0.47592628, green: 0.7291927338, blue: 0.9634214044, alpha: 1)
        default:
            self.weekdayLabel.textColor = .lightGray
        }
    }
}

class Example1Cell: CalendarViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectedBackgroundView?.isHidden = !selected
        selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.47592628, green: 0.7291927338, blue: 0.9634214044, alpha: 1)
        updateDayLabel()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }
    
    override func setEnabled(_ enabled: Bool, animated: Bool) {
        super.setEnabled(enabled, animated: animated)
        updateDayLabel()
    }
    
    override func update(with date: CalendarDate) {
        super.update(with: date)
        updateDayLabel()
    }
    
    private func updateDayLabel() {
        self.dayLabel.isHidden = !self.isEnabled
        self.dayLabel.font = UIFont.systemFont(ofSize: 16)
        if isSelected {
            self.dayLabel.textColor = .white
            self.dayLabel.font = UIFont.boldSystemFont(ofSize: 16)
        }else if self.date?.weekday == .sunday {
            self.dayLabel.textColor = #colorLiteral(red: 0.951656878, green: 0.500697732, blue: 0.4544605613, alpha: 1)
        }else if self.date?.weekday == .saturday {
            self.dayLabel.textColor = #colorLiteral(red: 0.47592628, green: 0.7291927338, blue: 0.9634214044, alpha: 1)
        }else  {
            self.dayLabel.textColor = .lightGray
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectedBackgroundView?.frame = CGRect(x: (contentView.frame.width - 32) * 0.5,
                                               y: (contentView.frame.height - 32) * 0.5,
                                               width: 32, height: 32)
        selectedBackgroundView?.layer.cornerRadius = 16
    }
}

let example1View = CalendarView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
example1View.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
example1View.separatorAxis = .horizontal
example1View.outerlineStyle = .none
example1View.separatorStyle = .custom(color: .lightGray, width: 1.0)
example1View.headerSeparatorStyle = .custom(color: .lightGray, width: 3.0)
example1View.registerHeaderCell(Example1HeaderCell.self)
example1View.registerCell(Example1Cell.self)
example1View.configure()
example1View.select(at: today, animated: true)

//: #### Example 2
class Example2HeaderCell: CalendarHeaderViewCell {
    override func configure(with weekday: Weekday) {
        super.configure(with: weekday)
        self.weekdayLabel.font = UIFont.systemFont(ofSize: 12)
        self.weekdayLabel.textColor = .lightGray
    }
}

class Example2Cell: CalendarViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        selectedBackgroundView?.isHidden = !selected
        selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.47592628, green: 0.7291927338, blue: 0.9634214044, alpha: 1)
        updateDayLabel()
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
    }
    
    override func setEnabled(_ enabled: Bool, animated: Bool) {
        super.setEnabled(enabled, animated: animated)
        updateDayLabel()
    }
    
    override func update(with date: CalendarDate) {
        super.update(with: date)
        updateDayLabel()
    }
    
    private func updateDayLabel() {
        self.dayLabel.isHidden = !self.isEnabled
        self.dayLabel.font = UIFont.systemFont(ofSize: 12)
        if isSelected {
            self.dayLabel.textColor = .white
            self.dayLabel.font = UIFont.boldSystemFont(ofSize: 12)
        }else if self.date?.weekday == .sunday {
            self.dayLabel.textColor = #colorLiteral(red: 0.951656878, green: 0.500697732, blue: 0.4544605613, alpha: 1)
        }else  {
            self.dayLabel.textColor = .lightGray
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        dayLabel.frame = CGRect(x: 4, y: 4, width: 24, height: 24)
        selectedBackgroundView?.frame = dayLabel.frame
        selectedBackgroundView?.layer.cornerRadius = dayLabel.bounds.width * 0.5
    }
}

let example2View = CalendarView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
example2View.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
example2View.outerlineStyle = .custom(color: .lightGray, width: 3.0)
example2View.separatorStyle = .custom(color: .lightGray, width: 1.0)
example2View.headerSeparatorStyle = .custom(color: .lightGray, width: 3.0)
example2View.registerHeaderCell(Example2HeaderCell.self)
example2View.registerCell(Example2Cell.self)
example2View.configure()
example2View.select(at: today, animated: true)
