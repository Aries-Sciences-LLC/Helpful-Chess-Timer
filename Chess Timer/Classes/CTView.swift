//
//  CTView.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 12/31/20.
//  Copyright © 2020 Ozan Mirza. All rights reserved.
//

import UIKit

class CTView: UIView {

    override func didMoveToSuperview() {
        layer.cornerRadius = 5
        layer.masksToBounds = true
        
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 0.4
    }
}
