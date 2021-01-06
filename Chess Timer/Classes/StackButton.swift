//
//  StackButton.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import UIKit

class StackButton: UIButton {
    func apply(palette: Widget) {
        layer.cornerRadius = 25
        layer.borderWidth = 0.4
        layer.masksToBounds = true
        
        tintColor = palette.tint?.color
        backgroundColor = palette.background?.color
        borderColor = palette.border?.color.withAlphaComponent(0.6)
    }
    
    override func didMoveToSuperview() {
        superview?.shadow(offset: CGSize(width: 3, height: 2), opacity: 0.93)
    }
}
