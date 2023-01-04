//
//  MoveBottomHalfCalculation.swift
//  Rectangle
//
//  Created by Eric Soroos on 6/5/20.
//  Copyright © 2020 Ryan Hanson. All rights reserved.
//

import Foundation

class MoveBottomHalfCalculation: WindowCalculation {
    
    override func calculateRect(_ window: Window, lastAction: RectangleAction?, visibleFrameOfScreen: CGRect, action: WindowAction) -> RectResult {
        
        var calculatedWindowRect = window.rect
        calculatedWindowRect.size.height = floor(visibleFrameOfScreen.height / 2.0)
        calculatedWindowRect.origin.y = visibleFrameOfScreen.minY
        
        return RectResult(calculatedWindowRect)

    }
}
