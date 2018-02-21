//
//  PieChart.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 19/5/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//

import UIKit

class PieChart: UIView {
    
    let isManha: String
    let isTarde: String
    let isNoite: String
    
    init? (isManha: String,
        isTarde: String,
        isNoite: String){
        
        self.isManha = isManha
        self.isTarde = isTarde
        self.isNoite = isNoite
        
        super.init(frame:CGRect())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        
        if (isManha == "true"){
            drawSlice(rect: rect, startPercent: 0, endPercent: 30, color: #colorLiteral(red: 0.7134557424, green: 0.7134557424, blue: 0.7134557424, alpha: 1))
        }else if (isManha == "false"){
            drawSlice(rect: rect, startPercent: 0, endPercent: 30, color: UIColor.clear)
        }
        if (isTarde == "true"){
            drawSlice(rect: rect, startPercent: 30, endPercent: 60, color: #colorLiteral(red: 0.4836215102, green: 0.4836215102, blue: 0.4836215102, alpha: 1))
        } else if (isTarde == "false"){
            drawSlice(rect: rect, startPercent: 30, endPercent: 60, color: UIColor.clear)
        }
        if (isNoite == "true"){
            drawSlice(rect: rect, startPercent: 60, endPercent: 90, color: #colorLiteral(red: 0.2185913706, green: 0.2185913706, blue: 0.2185913706, alpha: 1))
        }else if (isNoite == "false"){
            drawSlice(rect: rect, startPercent: 60, endPercent: 90, color: UIColor.clear)
        }
        
        
        super.draw(rect)
    }
    
    func drawSlice(rect: CGRect, startPercent: CGFloat, endPercent: CGFloat, color: UIColor) {
        let center = CGPoint(x: rect.origin.x + rect.width / 2, y: rect.origin.y + rect.height / 2)
        let radius = min(rect.width, rect.height) / 2
        let startAngle = startPercent / 90 * CGFloat(Double.pi) * 2 - CGFloat(Double.pi)
        let endAngle = endPercent / 90 * CGFloat(Double.pi) * 2 - CGFloat(Double.pi)
        let path = UIBezierPath()
        path.move(to: center)
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        path.close()
        color.setFill()
        path.fill()
    }


}
