//
//  Palette.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import Foundation

struct Palette: Codable {
    var name: String
    
    var main: Widget
    var secondary: Widget
    
    var buttons: Widget
}

extension Palette: Equatable {
    static func == (lhs: Palette, rhs: Palette) -> Bool {
        return
            lhs.name == rhs.name &&
            lhs.main == rhs.main &&
            lhs.secondary == rhs.secondary &&
            lhs.buttons == rhs.buttons
    }
}
