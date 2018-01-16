# TinyCalendar
![Xcode](https://img.shields.io/badge/Xcode-8.3-brightgreen.svg)
![Swift](https://img.shields.io/badge/Swift-3.1-brightgreen.svg)

TinyCalendar is simple calendar view.

## Environment

* iOS8 higher
* Xcode 8.3
* Swift 3.1

## Usage

Initialize as bellow:
```swift
let calendarView = CalendarView(frame: CGRect(x: 0, y: 0, width: 375, height: 375))
calendarView.configure()
```

Changes year/month as bellow:
```swift
calendarView.update(year: 2017, month: 10)
```

Also you can customize calendar cell just like UITableViewCell's cell.
```swift
calendarView.registerHeaderCell(CustomHeaderCell.self)
calendarView.registerCell(CustomCell.self)
```
Please see the details in TinyCalendar.playground.

![example1](https://github.com/yshrkt/TinyCalendar/blob/master/Images/example1.png)

## Installation

### Carthage

To install it, simply add the following line to your `Cartfile`:

```
github "yshrkt/TinyCalendar"
```

## Licence

TinyCalendar is released under the MIT license. [See LICENSE](https://github.com/yshrkt/TinyCalendar/blob/master/LICENSE) for details.

## Author

[yshrkt](https://github.com/yshrkt)
