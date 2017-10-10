//
//  CalendarView.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/24.
//
//

import UIKit

open class CalendarView: UIView {
    fileprivate struct Constants {
        static let numberOfRows: Int = 6
        static let numberOfColumns: Int = 7
        static let defaultHeaderHeight: CGFloat = 28.0
    }
    
    // MARK: - Subviews
    public fileprivate(set) weak var contentView: UIView!
    fileprivate weak var outerlineView: GridView! {
        didSet {
            outerlineView.numberOfRows = 1
            outerlineView.numberOfColumns = 1
            outerlineView.separatorStyle = .none
        }
    }
    fileprivate weak var headerView: CalendarHeaderView! {
        didSet {
            headerView.numberOfColumns = Constants.numberOfColumns
        }
    }
    fileprivate weak var gridView: GridView! {
        didSet {
            gridView.numberOfRows = Constants.numberOfRows
            gridView.numberOfColumns = Constants.numberOfColumns
            gridView.outerlineStyle = .none
            gridView.showsOuterline = false
        }
    }
    fileprivate var headerCells: [CalendarHeaderViewCell] = []
    fileprivate var cells: [CalendarViewCell] = []
    private var dateIndexs: [CalendarDate: Int] = [:]
    private var touchedCell: CalendarViewCell?
    
    // MARK: - Properties
    public var contentInset: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var outerlineStyle: LineStyle {
        get {
            return outerlineView.outerlineStyle
        }
        
        set {
            outerlineView.outerlineStyle = newValue
        }
    }
    
    public var showsOuterline: Bool = true {
        didSet {
            outerlineView.showsOuterline = showsOuterline
            setNeedsLayout()
        }
    }
    
    public var separatorStyle: LineStyle {
        get {
            return gridView.separatorStyle
        }
        
        set {
            gridView.separatorStyle = newValue
            headerView.separatorStyle = newValue
        }
    }
    
    public var separatorAxis: LineAxis {
        get {
            return gridView.separatorAxis
        }
        
        set {
            gridView.separatorAxis = newValue
            headerView.separatorAxis = newValue
        }
    }
    
    public var headerSeparatorStyle: LineStyle {
        get {
            return headerView.headerSeparatorStyle
        }
        
        set {
            headerView.headerSeparatorStyle = newValue
        }
    }
    
    public var showsHeader: Bool = true {
        didSet {
            setNeedsLayout()
        }
    }
    
    public var allowsSelection: Bool = true
    
    public weak var delegate: CalendarViewDelegate?
    
    fileprivate var headerCellType: AnyClass?
    fileprivate var cellType: AnyClass?
    
    // MARK: - Initializer
    public override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }
    
    // MARK: - Public methods
    public func registerCell<T: CalendarViewCell>(_ cellType: T.Type) {
        self.cellType = cellType
    }
    
    public func registerHeaderCell<T: CalendarHeaderViewCell>(_ cellType: T.Type) {
        self.headerCellType = cellType
    }
    
    public func cellForDate(_ date: CalendarDate) -> CalendarViewCell? {
        guard let index = dateIndexs[date], index < cells.count else {
            return nil
        }
        return cells[index]
    }
    
    public func configure() {
        configureHeaderCells()
        configureCells()
        
        guard let today = CalendarDate.today() else {
            return
        }
        
        update(year: today.year, month: today.month)
    }
    
    public func update(year: Int, month: Int) {
        dateIndexs.removeAll()
        let dates = caleandarDatesAt(year: year, month: month)
        //print("\(dates)")
        delegate?.calendarView(self, willUpdateCellsFor: dates)
        dates.enumerated().forEach{
            dateIndexs[$0.element] = $0.offset
            let cell = cells[$0.offset]
            if cell.adjustsContentInsetAutomatically {
                let row: Int = $0.offset / Constants.numberOfColumns
                let col: Int = $0.offset % Constants.numberOfColumns
                let top: CGFloat = (row == 0) ? 0.0 : separatorStyle.width
                let left: CGFloat = (col == 0) ? 0.0 : separatorStyle.width
                cell.contentInset = UIEdgeInsets(top: top, left: left,
                                                 bottom: 0.0, right: 0.0)
            }
            cell.isSelected = false
            cell.isHighlighted = false
            cell.isEnabled = true
            let _ = delegate?.calendarView(self, willUpdateCellAt: $0.element)
            cell.update(with: $0.element)
            if $0.element.year == year && $0.element.month == month {
                cell.setEnabled(true, animated: false)
            }else {
                cell.setEnabled(false, animated: false)
            }
            delegate?.calendarView(self, didUpdateCellAt: $0.element)
        }
        delegate?.calendarView(self, didUpdateCellsFor: dates)
    }
    
    public func select(at date: CalendarDate, animated: Bool) {
        guard allowsSelection else {
            return
        }
        guard let cell = cellForDate(date), !cell.isSelected else {
            return
        }
        if let delegate = delegate, delegate.calendarView(self, willSelectCellAt: date) == nil {
            return
        }
        
        cell.setSelected(true, animated: animated)
        delegate?.calendarView(self, didSelectCellAt: date)
    }
    
    public func deselect(at date: CalendarDate, animated: Bool) {
        guard let cell = cellForDate(date), cell.isSelected else {
            return
        }
        if let delegate = delegate, delegate.calendarView(self, willDeselectCellAt: date) == nil {
            return
        }
        cell.setSelected(false, animated: animated)
        delegate?.calendarView(self, didDeselectCellAt: date)
    }
    
    func didTap(sender: UITapGestureRecognizer) {
        let pos = sender.location(in: contentView)
        for cell in cells {
            let p = cell.convert(pos, from: contentView)
            if cell.point(inside: p, with: nil) {
                
            }
        }
        
    }
    
    // MARK: - Override methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = self.bounds.inset(by: contentInset)
        
        let contentFrame = contentView.bounds
        
        var headerFrame = contentFrame
        headerFrame.origin.y += outerlineStyle.width.half
        if showsHeader {
            headerFrame.size.height = delegate?.heightForHeaderView(in: self) ?? Constants.defaultHeaderHeight
            headerView.frame = headerFrame
            headerView.alpha = 1.0
        }else {
            headerFrame.size.height = 0.0
            headerView.frame = headerFrame
            headerView.alpha = 0.0
        }
        headerView.layoutIfNeeded()
        
        var gridFrame = contentFrame
        gridFrame.origin.y = headerView.frame.maxY
        gridFrame.size.height -= headerView.frame.height + outerlineStyle.width.half
        gridView.frame = gridFrame
        
        var outerlineFrame = contentFrame
        outerlineFrame.size.height = gridView.gridFrame.height + headerView.frame.height + outerlineStyle.width
        outerlineFrame.size.width = gridView.gridFrame.width + outerlineStyle.width
        outerlineView.frame = outerlineFrame
        
        headerCells.enumerated().forEach {
            let cellFrame = headerView.cellFrame(at: $0.offset)
            //print("header-cell: \(cellFrame)")
            $0.element.frame = cellFrame
        }
        
        cells.enumerated().forEach {
            var cellFrame = gridView.cellAt(row: $0.offset/Constants.numberOfColumns, column: $0.offset%Constants.numberOfColumns)
            //print("cell: \(cellFrame)")
            cellFrame.origin.x += gridView.frame.x
            cellFrame.origin.y += gridView.frame.y
            $0.element.frame = cellFrame
        }
    }
    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        guard allowsSelection else {
            return
        }
        guard let touch = touches.first else {
            return
        }
        let p = touch.location(in: contentView)
        for cell in cells where cell.isEnabled {
            guard let _ = cell.date else {
                continue
            }
            if cell.point(inside: cell.convert(p, from: contentView), with: event) {
                cell.setHighlighted(true, animated: true)
                touchedCell = cell
            }else {
                cell.setHighlighted(false, animated: true)
            }
        }
    }
    
    open override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        guard allowsSelection else {
            touchedCell?.setHighlighted(false, animated: true)
            touchedCell = nil
            return
        }
        guard let touch = touches.first else {
            return
        }
        let p = touch.location(in: contentView)
        if let cell = touchedCell {
            guard let _ = cell.date else {
                return
            }
            if !cell.point(inside: cell.convert(p, from: contentView), with: event) {
                cell.setHighlighted(false, animated: true)
            }
        }
    }
    
    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard allowsSelection else {
            touchedCell?.setHighlighted(false, animated: true)
            touchedCell = nil
            return
        }
        for cell in cells where cell.isEnabled {
            guard let date = cell.date else {
                continue
            }
            if cell == touchedCell && cell.isHighlighted {
                cell.setHighlighted(false, animated: true)
                self.select(at: date, animated: true)
            }else {
                cell.setHighlighted(false, animated: true)
                self.deselect(at: date, animated: true)
            }
        }
        touchedCell = nil
    }
    
    open override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        guard allowsSelection else {
            touchedCell?.setHighlighted(false, animated: true)
            touchedCell = nil
            return
        }
        for cell in cells where cell.isEnabled  {
            guard let date = cell.date else {
                continue
            }
            cell.setHighlighted(false, animated: true)
            self.deselect(at: date, animated: true)
        }
        touchedCell = nil
    }
}

fileprivate extension CalendarView {
    // MARK: - Private methods
    func _commonInit() {
        self.backgroundColor = .white
        
        let contentView = UIView(frame: .zero)
        contentView.frame = self.bounds.inset(by: contentInset)
        self.addSubview(contentView)
        self.contentView = contentView
        
        let headerView = CalendarHeaderView(frame: .zero)
        self.contentView.addSubview(headerView)
        self.headerView = headerView
        
        let gridView = GridView(frame: .zero)
        self.contentView.addSubview(gridView)
        self.gridView = gridView
        
        let outerlineView = GridView(frame: .zero)
        self.contentView.addSubview(outerlineView)
        self.outerlineView = outerlineView
        
        self.setNeedsLayout()
    }
    
    func caleandarDatesAt(year: Int, month: Int) -> [CalendarDate] {
        let priviousDays = daysAt(year: year - ((month > 1) ? 0 : 1), month: (month > 1) ? month - 1 : 12)
        let currentDays = daysAt(year: year, month: month)
        let nextDays = daysAt(year: year + ((month < 12) ? 0 : 1), month: (month < 12) ? month + 1 : 1)
        
        var dates: [CalendarDate] = []
        if let firstWeekday = currentDays.first?.weekday, firstWeekday.rawValue > Weekday.sunday.rawValue {
            let addingDays = firstWeekday.rawValue - Weekday.sunday.rawValue
            dates.append(contentsOf: priviousDays[(priviousDays.count-addingDays)..<priviousDays.count])
        }
        dates.append(contentsOf: currentDays)
        let remainingDays = (Constants.numberOfColumns * Constants.numberOfRows) - dates.count
        if remainingDays > 0 {
            dates.append(contentsOf: nextDays[0..<remainingDays])
        }
        return dates
    }
    
    func daysAt(year: Int, month: Int) -> [CalendarDate] {
        let calendar: Calendar = { () -> Calendar in
            var cal = Calendar(identifier: .gregorian)
            cal.locale = Locale.current
            return cal
        }()
        
        let dateComponents = { (year: Int, month: Int) -> DateComponents in
            var dc = DateComponents()
            dc.year = year
            dc.month = month
            return dc
        }(year, month)
        
        guard let firstDay = calendar.date(from: dateComponents),
            let monthRange = calendar.range(of: .day, in: .month, for: firstDay) else {
                return []
        }
        
        let firstWeekday = calendar.component(.weekday, from: firstDay)
        
        var days: [CalendarDate] = []
        let numOfWeekdays: Int = Weekday.all.count
        for i in 0..<monthRange.count {
            let weekday = Weekday(rawValue: (firstWeekday - 1  + i) % numOfWeekdays + 1)
            days.append(CalendarDate(year: year, month: month, day: i + 1, weekday: weekday!))
        }
        return days
    }
    
    
    func configureHeaderCells() {
        for cell in headerCells {
            cell.removeFromSuperview()
        }
        headerCells = []
        for i in 0..<Constants.numberOfColumns {
            let cell = { [weak self] () -> CalendarHeaderViewCell in
                if let cellType = self?.headerCellType as? CalendarHeaderViewCell.Type {
                    return cellType.init(frame: .zero)
                }else {
                    return CalendarHeaderViewCell(frame: .zero)
                }
            }()
            cell.frame = headerView.cellFrame(at: i)
            let left = (i == 0) ? 0.0 : separatorStyle.width
            cell.contentInset = UIEdgeInsets(top: separatorStyle.width,
                                             left: left,
                                             bottom: headerSeparatorStyle.width.half,
                                             right: 0.0)
            if let weekday = Weekday(rawValue: i + 1) {
                cell.configure(with: weekday)
                delegate?.calendarView(self, configureHeaderCellAt: weekday)
            }
            
            headerView.addSubview(cell)
            headerCells.append(cell)
        }
        contentView.bringSubview(toFront: outerlineView)
    }
    
    func configureCells() {
        for cell in cells {
            cell.removeFromSuperview()
        }
        cells = []
        for i in 0..<(Constants.numberOfRows * Constants.numberOfColumns) {
            let cell = { [weak self] () -> CalendarViewCell in
                if let cellType = self?.cellType as? CalendarViewCell.Type {
                    return cellType.init(frame: .zero)
                }else {
                    return CalendarViewCell(frame: .zero)
                }
                }()
            var cellFrame = gridView.cellAt(row: i/Constants.numberOfColumns, column: i%Constants.numberOfColumns)
            cellFrame.origin.x += gridView.frame.x
            cellFrame.origin.y += gridView.frame.y
            cell.frame = cellFrame
            contentView.addSubview(cell)
            cells.append(cell)
        }
        contentView.bringSubview(toFront: outerlineView)
    }
}

