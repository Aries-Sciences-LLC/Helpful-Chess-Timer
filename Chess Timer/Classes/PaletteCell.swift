//
//  PaletteCell.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import UIKit

protocol PaletteCellDelegate {
    func handleSelection(for palette: Palette)
}

class PaletteCell: UICollectionViewCell {
    
    static let reuseID = "PaletteCell"
    
    private var palette: Palette!
    public var delegate: PaletteCellDelegate!
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var main: UIView!
    @IBOutlet weak var secondary: UIView!
    
    @IBAction func set(_ sender: UIButton!) {
        delegate.handleSelection(for: palette)
        update()
    }
    
    public func configure(with palette: Palette) {
        self.palette = palette
        
        title.text = palette.name
        main.backgroundColor = palette.main.background?.color
        secondary.backgroundColor = palette.secondary.background?.color
        
        main.layer.borderColor = UIColor.systemGray3.cgColor
        secondary.layer.borderColor = UIColor.systemGray3.cgColor
        
        update()
    }
    
    public func deselect() {
        update()
    }
    
    private func update() {
        let animation = CABasicAnimation(keyPath: "borderWidth")
        
        animation.fromValue = layer.borderWidth
        
        if PaletteManager.shared.current == palette {
            animation.toValue = 12
            layer.borderColor = UIColor.quaternarySystemFill.cgColor
        } else {
            animation.toValue = 0.0
            layer.borderColor = UIColor.white.cgColor
        }
        
        animation.duration = 0.3
        animation.fillMode = .forwards
        
        layer.add(animation, forKey: animation.keyPath)
    }
}
