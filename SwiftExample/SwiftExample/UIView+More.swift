//
//  UIView+More.swift
//  Maavak
//
//  Created by Alon Genosar on 7/27/17.
//  Copyright © 2017 Alon Genosar. All rights reserved.
//

import UIKit
import ObjectiveC

extension UIView {
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set (value){
            self.frame=CGRect(x: value, y: self.frame.origin.y, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(value) {
            self.frame=CGRect(x: self.frame.origin.x, y: value, width: self.frame.size.width, height: self.frame.size.height)
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set (value){
            self.frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: value, height: self.frame.size.height)
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set (value){
            self.frame=CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height:value)
        }
    }
    
    var bottom: CGFloat {
        get {
            return y+height
        }
        set (value){
            height = value - y
        }
    }
    
    var right: CGFloat {
        get {
            return x+width
        }
        set (value){
            width = value - x
        }
    }
    
    var centerX: CGFloat {
        get {
            return center.x
        }
        set (value){
            center = CGPoint(x:value,y:center.y)
        }
    }
    
    var centerY: CGFloat {
        get {
            return center.y
        }
        set (value){
            center = CGPoint(x:center.x,y:value)
        }
    }
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame = CGRect(x:x,y:y,width:newValue.width,height:newValue.height)
        }
    }
    func scale(by scale:CGFloat) {
        self.width *= scale
        self.height *= scale
    }
    func startBlinking(times: Int = -1,timeInterval:TimeInterval = 0.3) {
        let animateion: CABasicAnimation = CABasicAnimation(keyPath: "hidden")
        animateion.fromValue = 0
        animateion.toValue = 1
        animateion.duration = timeInterval
        animateion.autoreverses = true
        animateion.repeatCount = (times>0 ? Float(times) : Float(LLONG_MAX))
        self.layer.add(animateion, forKey: "hidden")
    }
    func stopBlinking(_ isHidden:Bool = false) {
        self.layer.removeAnimation(forKey: "hidden")
        self.layer.isHidden = isHidden
    }
    func removeAllConstraints() {
        
        removeConstraints(constraints)
        translatesAutoresizingMaskIntoConstraints = true
        
        if let superview = self.superview {
            let constraints = self.superview?.constraints.filter{
                $0.firstItem as? UIView == self || $0.secondItem as? UIView == self
                } ?? []
            
            superview.removeConstraints(constraints)
        }
    }
    func removeSubViews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    func copyView<T: UIView>() -> T {
        let v =  NSKeyedUnarchiver.unarchiveObject(with: NSKeyedArchiver.archivedData(withRootObject: self)) as! T
        (v as UIView).layer.borderWidth = self.layer.borderWidth
        (v as UIView).layer.borderColor = self.layer.borderColor
        (v as UIView).layer.cornerRadius = self.layer.cornerRadius
        return v
    }
}
