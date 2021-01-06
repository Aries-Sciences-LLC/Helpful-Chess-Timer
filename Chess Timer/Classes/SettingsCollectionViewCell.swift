//
//  SettingsCollectionViewCell.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/4/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import UIKit
import ScalingCarousel

protocol SettingsCollectionViewCellDelegate {
    func cellWasSelected(cell: SettingsCollectionViewCell)
}
class SettingsCollectionViewCell: ScalingCarouselCell {
    static let reuseID = "SettingsCell"
    
    @IBOutlet weak var container: CTView!
    @IBOutlet weak var content: UILabel!
    
    var item: Any?
    var delegate: SettingsCollectionViewCellDelegate?
    
    func configure(with text: String, of value: Any) {
        item = value
        content.text = text
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        layer.masksToBounds = false
        contentView.layer.masksToBounds = false
        
        mainView.layer.shadowColor = UIColor.gray.cgColor
        
        container.layer.cornerRadius = 10
        container.layer.borderColor = UIColor.tertiarySystemFill.cgColor
        container.layer.insertSublayer(GradientsManager.shared.gradient(for: contentView.bounds, upon: traitCollection.userInterfaceStyle == .dark), at: 0)
    }
    
    override func willTransition(from oldLayout: UICollectionViewLayout, to newLayout: UICollectionViewLayout) {
        container.layer.sublayers?.forEach({
            if $0 is CAGradientLayer {
                $0.frame = container.bounds
            }
        })
    }
    
    @IBAction func userSelectedCell(_ sender: Any) {
        guard let delegate = delegate else {
            return
        }
        
        guard let sender = sender as? UIButton else {
            return
        }
        
        sender.setTitle("SELECTED", for: .normal)
        
        delegate.cellWasSelected(cell: self)
    }
}
