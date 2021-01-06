//
//  PrefrencesViewController.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

class PrefrencesViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        traitCollectionDidChange(traitCollection)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
//        let colors: [[UIColor]] = [
//            [.init("#FFFFFF"), .init("#FFFBFB")],
//            [.init("#000000"), .init("#00040b")],
//        ]
//        
//        switch traitCollection.userInterfaceStyle {
//        case .dark:
//            view.gradient(from: colors[1], with: .radial)
//            return
//        case .unspecified:
//            view.gradient(from: colors[0], with: .radial)
//        case .light:
//            view.gradient(from: colors[0], with: .radial)
//        @unknown default:
//            break
//        }
    }
}
