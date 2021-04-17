//
//  progress.swift
//  Climascale
//
//  Created by Adrian Reilly on 4/14/21.
//

import UIKit
let trackLayer = CAShapeLayer()
let shapeLayer = CAShapeLayer()
class progress: UIView {
    //let trackLayer = CAShapeLayer()
    //let shapeLayer = CAShapeLayer()
    
    override func draw(_ rect: CGRect) {
        
        let width = rect.width
        let height = rect.height
        let lineWidth = 0.1 * min(width,height)
        
        
        //let trackLayer = CAShapeLayer()
        //let shapeLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2), radius: (min(width, height) - lineWidth) / 2, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat((M_PI * 2.0) - M_PI_2), clockwise: true)
        //let circularPath = UIBezierPath(arcCenter: CGPoint(x: width / 2, y: height / 2), radius: (min(width, height) - lineWidth) / 2, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: false)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        layer.addSublayer(trackLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        layer.addSublayer(shapeLayer)
        
            
       
        
    }
    
    

}

public func animateIt() {
    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    basicAnimation.fromValue = 1
    basicAnimation.toValue = 0.5
    basicAnimation.duration = 2
    basicAnimation.fillMode = .forwards
    basicAnimation.isRemovedOnCompletion = false
    shapeLayer.add(basicAnimation, forKey: "animation")
    
}
