//
//  PassTouchesScrollView.swift
//  Comidinhas
//
//  Created by Nicolas Melo on 13/9/17.
//  Copyright © 2017 Nicolas Melo. All rights reserved.
//
import UIKit

protocol PassTouchesScrollViewDelegate {
    func touchBegan()
    func touchMoved()
}

class PassTouchesScrollView: UIScrollView {
    
    var delegatePass : PassTouchesScrollViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        
        // Notify it's delegate about touched
        self.delegatePass?.touchBegan()
        
        if self.isDragging == true {
            self.next?.touchesBegan(touches, with: event)
        } else {
            super.touchesBegan(touches, with: event)
        }
        
    }
    
    func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent)  {
        
        // Notify it's delegate about touched
        self.delegatePass?.touchMoved()
        
        if self.isDragging == true {
            self.next?.touchesMoved(touches, with: event)
        } else {            
            super.touchesMoved(touches, with: event)
        }
    }   
}
