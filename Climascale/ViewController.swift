//
//  ViewController.swift
//  Climascale
//
//  Created by Anton Schuster on 3/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    //progress circle
    let shape = CAShapeLayer()
    //

 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //progress circle
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 210, y: 350), radius: 150, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat((M_PI * 2.0) - M_PI_2), clockwise: true)
        //interior
        let trackShape = CAShapeLayer()
        trackShape.path = circlePath.cgPath
        trackShape.fillColor = UIColor.clear.cgColor
        trackShape.lineWidth = 15
        trackShape.strokeColor = UIColor.lightGray.cgColor
        view.layer.addSublayer(trackShape)
        //
        
        
        shape.path = circlePath.cgPath
        shape.lineWidth = 15
        shape.strokeColor = UIColor.blue.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.strokeEnd = 0
        view.layer.addSublayer(shape)
        
        //let button = UIButton(frame: CGRect(x:20, y: view.frame.size.height-70, width: view.frame.size.width-40, height: 50))
        //view.addSubview(button)
        //button.setTitle("myTest", for: .normal)
        //button.backgroundColor = .systemGreen
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 0.5
        animation.duration = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        shape.add(animation, forKey: "animation")
        //button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        //
    
    }
    
    //progress circle animation if we want button
    //@objc func didTapButton() {
        //let animation = CABasicAnimation(keyPath: "strokeEnd")
        //animation.toValue = 0.5
        //animation.duration = 1
        //animation.isRemovedOnCompletion = false
        //animation.fillMode = .forwards
        //shape.add(animation, forKey: "animation")
    
    //}
    //


}

