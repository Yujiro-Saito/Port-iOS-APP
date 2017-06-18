//
//  SignInUpViewDesign.swift
//  Project6
//
//  Created by  Yujiro Saito on 2017/06/11.
//  Copyright © 2017年 yujiro_saito. All rights reserved.
//

import UIKit

class SignInUpViewDesign: UIView, CAAnimationDelegate {
    let gradientLayer = CAGradientLayer()
    
    
    let colors: [CGColor] = [
        #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
        #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),
        #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),
        #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),
        #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
        #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),
        #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        ].map { $0.cgColor }
    
    
    var currentIndex = (start: 1, end: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        
        gradientLayer.colors = [colors[currentIndex.start], colors[currentIndex.end]]
        
        gradientLayer.drawsAsynchronously = true
        layer.addSublayer(gradientLayer)
        
       // aniamte()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    func aniamte() {
        currentIndex = ((currentIndex.start + 1) % colors.count, (currentIndex.end + 1) % colors.count)
        
        let fromColors = gradientLayer.colors
        let anim = CABasicAnimation(keyPath: "colors")
        anim.fromValue = fromColors
        
        anim.toValue =  [colors[currentIndex.start], colors[currentIndex.end]]
        
        anim.duration = 5
                anim.delegate = self
        gradientLayer.add(anim, forKey: "colors")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        gradientLayer.colors = [colors[currentIndex.start], colors[currentIndex.end]]
        aniamte()
    }
}