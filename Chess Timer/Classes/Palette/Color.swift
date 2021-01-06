//
//  Color.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

struct Color: Codable {
    var hex: String
    
    var color: UIColor {
        return UIColor(hex)
    }
}

extension Color: Equatable {
    static func == (lhs: Color, rhs: Color) -> Bool {
        return lhs.hex == rhs.hex
    }
}
