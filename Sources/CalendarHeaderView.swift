//
//  CalendarHeaderView.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/26.
//
//

import UIKit

open class CalendarHeaderView: UIView {
    // MARK: - Subviews
    fileprivate weak var gridView: GridView! {
        didSet {
            gridView.numberOfRows = 1
            gridView.outerlineStyle = .none
            gridView.showsOuterline = false
        }
    }
    
    // MARK: - Properties
    public var separatorStyle: LineStyle {
        get {
            return gridView.separatorStyle
        }
        
        set {
            gridView.separatorStyle = newValue
        }
    }
    
    public var separatorAxis: LineAxis {
        get {
            return gridView.separatorAxis
        }
        
        set {
            gridView.separatorAxis = newValue
        }
    }
    
    public var headerSeparatorStyle: LineStyle = .headerSeparator {
        didSet {
            setNeedsDisplay()
        }
    }
    
    public var numberOfColumns: Int = 7 {
        didSet {
            setNeedsLayout()
        }
    }
    
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
    public func cellFrame(at index: Int) -> CGRect {
        return gridView.cellAt(row: 0, column: index)
    }
    
    // MARK: - Override methods
    open override func layoutSubviews() {
        super.layoutSubviews()
        var gridFrame = self.bounds
        gridFrame.size.height -= headerSeparatorStyle.width
        gridView.frame = gridFrame
        
        gridView.setNeedsDisplay()
        self.setNeedsDisplay()
    }
    
    open override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        let adjust: CGFloat = 0.5 / UIScreen.main.scale
        
        context.setFillColor(self.backgroundColor?.cgColor ?? UIColor.clear.cgColor)
        context.fill(rect)
        
        context.setStrokeColor(headerSeparatorStyle.color.cgColor)
        context.setLineWidth(headerSeparatorStyle.width)
        context.move(to: CGPoint(x: adjust, y: self.bounds.height - headerSeparatorStyle.width.half + adjust))
        context.addLine(to: CGPoint(x: self.bounds.width - adjust, y: self.bounds.height - headerSeparatorStyle.width.half + adjust))
        context.strokePath()
    }
}

fileprivate extension CalendarHeaderView {
    func _commonInit() {
        self.backgroundColor = .clear
        let gridView = GridView(frame: .zero)
        gridView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(gridView)
        self.gridView = gridView
        
        self.setNeedsLayout()
    }
}
