//
//  MoveTopHalfCalculation.swift
//  Rectangle
//
//  Created by Eric Soroos on 6/5/20.
//  Copyright © 2020 Ryan Hanson. All rights reserved.
//

import Foundation

class MoveTopHalfCalculation: WindowCalculation {
    
    override func calculateRect(_ window: Window, lastAction: RectangleAction?, visibleFrameOfScreen: CGRect, action: WindowAction) -> RectResult {
        
        var calculatedWindowRect = window.rect
        calculatedWindowRect.size.height = floor(visibleFrameOfScreen.height / 2.0)
        calculatedWindowRect.origin.y += visibleFrameOfScreen.height + (visibleFrameOfScreen.height.truncatingRemainder(dividingBy: 2.0))

        return RectResult(calculatedWindowRect)

    }
}

