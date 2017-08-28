//
//  GridView.swift
//  TinyCalendar
//
//  Created by Yoshihiro Kato on 2017/08/26.
//
//

import UIKit

class GridView: UIView {
    // MARK: - Properties
    var outerlineStyle: LineStyle = .outerline {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var showsOuterline: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var separatorStyle: LineStyle = .separator {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var separatorAxis: LineAxis = .both {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var numberOfRows: Int = 6 {
        didSet {
            setNeedsDisplay()
        }
    }

    var numberOfColumns: Int = 7 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var gridFrame: CGRect {
        let cellSize = self.cellSize
        let origin = offset(with: cellSize)
        return CGRect(origin: origin,
                      size: CGSize(width: cellSize.width * numberOfColumns.cgFloat,
                                   height: cellSize.height * numberOfRows.cgFloat))
    }
    
    private var cellSize: CGSize {
        var w: CGFloat = ((frame.width - outerlineStyle.width) / numberOfColumns.cgFloat).rounded(.down)
        var h: CGFloat = ((frame.height - outerlineStyle.width) / numberOfRows.cgFloat).rounded(.down)
        w += (frame.width - w * numberOfColumns.cgFloat > numberOfColumns.cgFloat) ? 1.0 : 0.0
        h += (frame.height - h * numberOfRows.cgFloat > numberOfRows.cgFloat) ? 1.0 : 0.0
        return CGSize(width: w, height: h).rounded(.down)
    }
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        _commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        _commonInit()
    }
    
    // MARK: - Public methods
    func cellAt(row: Int, column: Int) -> CGRect {
        let size = cellSize
        var origin = offset(with: size)
        origin.x += size.width * column.cgFloat
        origin.y += size.height * row.cgFloat
        return CGRect(origin: origin, size: size)
    }
    
    // MARK: - Private methods
    private func _commonInit() {
        self.backgroundColor = .clear
        setNeedsDisplay()
    }
    
    private func offset(with cell: CGSize) -> CGPoint {
        let x: CGFloat = (frame.width - cell.width * numberOfColumns.cgFloat).half
        let y: CGFloat = 0.0
        return CGPoint(x: x, y: y).rounded(.down)
    }
    
    // MARK: - Override methods
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        context.setFillColor(self.backgroundColor?.cgColor ?? UIColor.clear.cgColor)
        context.fill(rect)
        
        let cell: CGSize = self.cellSize
        let offset: CGPoint = self.offset(with: cell)
        let adjust: CGFloat = 0.5 / UIScreen.main.scale
        
        context.setStrokeColor(separatorStyle.color.cgColor)
        context.setLineWidth(separatorStyle.width)
        if separatorAxis.contains(.vertical) {
            for i in 1..<numberOfColumns {
                let x = offset.x + cell.width * CGFloat(i)
                context.beginPath()
                context.move(to: CGPoint(x: x + adjust, y: offset.y - adjust))
                context.addLine(to: CGPoint(x: x + adjust, y: offset.y + cell.height * numberOfRows.cgFloat + adjust))
                context.strokePath()
            }
        }
        
        if separatorAxis.contains(.horizontal) {
            for i in 1..<numberOfRows {
                let y = offset.y + cell.height * CGFloat(i)
                context.beginPath()
                context.move(to: CGPoint(x: offset.x - adjust, y: y + adjust))
                context.addLine(to: CGPoint(x: offset.x + cell.width * numberOfColumns.cgFloat + adjust, y: y + adjust))
                context.strokePath()
            }
        }
        
        context.setStrokeColor(outerlineStyle.color.cgColor)
        context.setLineWidth(outerlineStyle.width)
        if showsOuterline {
            let x = outerlineStyle.width.half - adjust
            let y = outerlineStyle.width.half - adjust
            context.beginPath()
            context.addRect(CGRect(x: x, y: y,
                                   width: cell.width * numberOfColumns.cgFloat - outerlineStyle.width + adjust.twice,
                                   height: cell.height * numberOfRows.cgFloat - outerlineStyle.width + adjust.twice))
            context.strokePath()
        }
    }
}

