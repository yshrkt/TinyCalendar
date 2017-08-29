//
//  CalendarHeaderViewCell.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/26.
//
//

import UIKit

open class CalendarHeaderViewCell: UIView {
    // MARK: - Subviews
    public private(set) weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .clear
        }
    }
    public private(set) weak var weekdayLabel: UILabel! {
        didSet {
            weekdayLabel.backgroundColor = .clear
            weekdayLabel.textAlignment = .center
            weekdayLabel.font = UIFont.systemFont(ofSize: 16)
        }
    }
    
    // MARK: - Properties
    public private(set) var weekday: Weekday?
    
    open var contentInset: UIEdgeInsets = .zero {
        didSet {
            setNeedsLayout()
        }
    }
    
    // MARK: - Initializer
    public required override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }
    
    // MARK: - Public methods
    open func configure(with weekday: Weekday) {
        self.weekday = weekday
        weekdayLabel.text = weekday.shortSymbol
    }
    
    // MARK: - Override methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds.inset(by: contentInset)
        weekdayLabel.frame = contentView.bounds
    }
    
    // MARK: - Private methods
    private func _commonInit() {
        self.backgroundColor = .clear
        let contentView = UIView(frame: .zero)
        contentView.frame = self.bounds.inset(by: contentInset)
        self.addSubview(contentView)
        self.contentView = contentView
        
        let weekdayLabel = UILabel(frame: .zero)
        weekdayLabel.frame = self.contentView.bounds
        self.contentView.addSubview(weekdayLabel)
        self.weekdayLabel = weekdayLabel
    }
}
