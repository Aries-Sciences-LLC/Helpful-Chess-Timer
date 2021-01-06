//
//  UIView.swift
//  Chess Timer
//
//  Created by Ozan Mirza on 1/1/21.
//  Copyright © 2021 Ozan Mirza. All rights reserved.
//

import UIKit

extension UIView {
    func gradient(from colors: [UIColor], with type: CAGradientLayerType = .axial) {
        let gradient = CAGradientLayer()
        
        gradient.colors = colors.map({ (color) -> CGColor in
            return color.cgColor
        })
        gradient.type = type
        
        gradient.frame = frame
        
        gradient.startPoint = .zero
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.locations = [0.0, 1.0]
        
        layer.insertSublayer(gradient, at: 0)
    }
    
    func shadow(
        color: UIColor = .gray,
        offset: CGSize = .init(width: 2, height: 5),
        radius: CGFloat = 15,
        opacity: Float = 0.6
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func raise() {
        let animation = CABasicAnimation(keyPath: "shadowOpacity")
        animation.fromValue = layer.shadowOpacity
        animation.toValue = 1
        animation.duration = 0.3
        animation.fillMode = .forwards
        layer.add(animation, forKey: animation.keyPath)
    }
    
    func flash(options: UIView.KeyframeAnimationOptions = [.autoreverse, .repeat]) {
        UIView.animateKeyframes(withDuration: 1, delay: 0, options: options) {
            self.alpha = 0
        } completion: { _ in
            
        }
    }
    
    func removeAnimations() {
        layer.removeAllAnimations()
        flash(options: [])
    }
    
    func applyWarning() {
        let overlay = UIView(frame: bounds)
        overlay.backgroundColor = UIColor.red.withAlphaComponent(0.4)
        overlay.alpha = 0
        addSubview(overlay)
        
        NSLayoutConstraint.activate([
            overlay.topAnchor.constraint(equalTo: topAnchor),
            overlay.rightAnchor.constraint(equalTo: rightAnchor),
            overlay.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlay.leftAnchor.constraint(equalTo: leftAnchor),
        ])
        
        overlay.flash()
    }
    
    func removeWarning() {
        for subview in subviews {
            if subview.backgroundColor == UIColor.red.withAlphaComponent(0.9) {
                subview.removeFromSuperview()
            }
        }
    }
    
    var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
        } set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
