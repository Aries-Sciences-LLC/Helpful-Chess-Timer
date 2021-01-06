//
//  BaseViewController.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import UIKit
import ScreenCorners

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.frame = CGRect(x: 0.5, y: 0.5, width: view.frame.size.width - 1, height: view.frame.size.height - 1)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    
        let radius = UIScreen.main.displayCornerRadius
        view.layer.cornerRadius = radius == 0 ? 5 : radius + 5
    }
}
