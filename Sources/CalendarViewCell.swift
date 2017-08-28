//
//  CalendarViewCell.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/24.
//
//

import UIKit

open class CalendarViewCell: UIView {
    // MARK: - Subviews
    public private(set) weak var contentView: UIView! {
        didSet {
            contentView.backgroundColor = .clear
        }
    }
    public private(set) weak var dayLabel: UILabel! {
        didSet {
            dayLabel.backgroundColor = .clear
            dayLabel.textAlignment = .center
            dayLabel.font = UIFont.systemFont(ofSize: 18)
        }
    }
    public weak var selectedBackgroundView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            guard let view = selectedBackgroundView else {
                return
            }
            view.alpha = (isSelected) ? 1.0 : 0.0
            view.frame = self.bounds.inset(by: contentInset)
            self.insertSubview(view, at: 0)
        }
    }
    
    // MARK: - Properties
    public private(set) var date: CalendarDate?
    
    open var isSelected: Bool = false {
        didSet {
            guard isSelected != oldValue else {
                return
            }
            setSelected(isSelected, animated: false)
        }
    }
    
    open var isHighlighted: Bool = false {
        didSet {
            guard isHighlighted != oldValue else {
                return
            }
            setHighlighted(isHighlighted, animated: false)
        }
    }
    
    open var isEnabled: Bool = true {
        didSet {
            guard isEnabled != oldValue else {
                return
            }
            setEnabled(isEnabled, animated: false)
        }
    }
    
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
    open func setSelected(_ selected: Bool, animated: Bool) {
        isSelected = selected
        guard let selectedBackgroundView = selectedBackgroundView else {
            return
        }
        if animated {
            UIView.animate(withDuration: 0.16, animations: { [weak self] in
                selectedBackgroundView.alpha = selected ? 1.0 : 0.0
                self?.updateDayLabel()
            })
        }else {
            selectedBackgroundView.alpha = selected ? 1.0 : 0.0
            updateDayLabel()
        }
    }
    
    open func setHighlighted(_ highlighted: Bool, animated: Bool) {
        isHighlighted = highlighted
    }
    
    open func setEnabled(_ enabled: Bool, animated: Bool) {
        isEnabled = enabled
        updateDayLabel()
    }
    
    open func update(with date: CalendarDate) {
        self.date = date
        dayLabel.text = "\(date.day)"
        updateDayLabel()
    }
    
    // MARK: - Override methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = self.bounds.inset(by: contentInset)
        dayLabel.frame = contentView.bounds
        selectedBackgroundView?.frame = contentView.frame
    }
    
    // MARK: - Private methods
    private func _commonInit() {
        self.backgroundColor = .clear
        let contentView = UIView(frame: .zero)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.frame = self.bounds.inset(by: contentInset)
        self.addSubview(contentView)
        self.contentView = contentView
        
        let dayLabel = UILabel(frame: .zero)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        dayLabel.frame = self.contentView.bounds
        self.contentView.addSubview(dayLabel)
        self.dayLabel = dayLabel
        
        let selectedBackgroundView = UIView(frame: .zero)
        selectedBackgroundView.backgroundColor = UIColor.lightGray
        selectedBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        selectedBackgroundView.frame = self.contentView.bounds
        self.selectedBackgroundView = selectedBackgroundView
    }
    
    private func updateDayLabel () {
        if !isEnabled {
            dayLabel.textColor = .lightGray
        }else if isSelected {
            dayLabel.textColor = .white
        }else if let date = self.date {
            switch date.weekday {
            case .sunday:
                dayLabel.textColor = .red
            case .saturday:
                dayLabel.textColor = .blue
            default:
                dayLabel.textColor = .black
            }
        }
    }
}
