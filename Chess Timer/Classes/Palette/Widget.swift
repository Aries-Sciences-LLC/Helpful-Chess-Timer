//
//  Widget.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import Foundation

struct Widget: Codable {
    var background: Color?
    
    var title: Color?
    var subtitle: Color?
    
    var tint: Color?
    
    var border: Color?
}

extension Widget: Equatable {
    static func == (lhs: Widget, rhs: Widget) -> Bool {
        return
            lhs.background == rhs.background &&
            lhs.title == rhs.title &&
            lhs.subtitle == rhs.subtitle &&
            lhs.tint == rhs.tint &&
            lhs.border == rhs.border
    }
}
