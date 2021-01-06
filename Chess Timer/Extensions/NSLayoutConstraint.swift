//
//  NSLayoutConstraint.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/5/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    func prioritize(_ value: Bool) {
        isActive = value
    }
}
