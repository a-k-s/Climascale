//
//  roundButton1.swift
//  Climascale
//
//  Created by Adrian Reilly on 5/1/21.
//
import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    //gradient
    override func layoutSubviews() {
            super.layoutSubviews()
            gradientLayer.frame = bounds
        }
    
    private lazy var gradientLayer: CAGradientLayer = {
            let l = CAGradientLayer()
            l.frame = self.bounds
            //l.colors = [UIColor.systemYellow.cgColor, UIColor.systemPink.cgColor]
        l.colors = [UIColor(red: 0/255, green: 144/255, blue: 200/255, alpha: 1.0).cgColor, UIColor(red: 0/255, green: 170/255, blue: 170/255, alpha: 1.0).cgColor]
            l.startPoint = CGPoint(x: 0, y: 0.5)
            l.endPoint = CGPoint(x: 1, y: 0.5)
            l.cornerRadius = 16
            layer.insertSublayer(l, at: 0)
            return l
        }()
    

    
    
    
    
    
}
