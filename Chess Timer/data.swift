//
//  data.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 5/20/18.
//  Copyright © 2018 Ozan Mirza. All rights reserved.
//

import Foundation
import UIKit

var colors : [UIColor] = [UIColor.white, UIColor.white] // Player1, Player2

var times : [String] = [String(), String()] // Player1, Player2

var dataPassed = false // Set True When Settings Are Finished And Set False When Back To Setting

var nameOfWinner : String = "NO ONE!!!"
var winnerColor : UIColor = UIColor.clear

func resetData() {
    colors = [UIColor.white, UIColor.white]
    times = [String(), String()]
    dataPassed = false
    nameOfWinner = "NO ONE!!!"
    winnerColor = UIColor.clear
}
