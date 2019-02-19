//
//  HUD.swift
//  Snappers
//
//  Created by Alon Genosar on 11/02/2018.
//  Copyright © 2018 Snappers. All rights reserved.
//

import UIKit
//import Spring
 public typealias HUDCallback = ()-> Void


class HUDItemActivity: HUDItem {
    private var activity = UIActivityIndicatorView()
    @objc public convenience init(title:String) {
        self.init()
        self.title = title
    }
    override public func resume() {
        activity.activityIndicatorViewStyle = .whiteLarge
        addSubview(activity)
        activity.startAnimating()
    }
    override public func resign(){
        activity.stopAnimating()
    }
    override func layoutSubviews() {
        activity.center = self.center
    }
}


open class HUDItem:UIView {
    @objc open var title:String?
    @objc open var showCover:Bool = true
    @objc open var coverColor:UIColor = UIColor.black
    @objc open var coverAlpha:CGFloat = 0.5
    @objc open var name:String?
    @objc open var titleBackgroundColor:UIColor = UIColor.clear
    @objc open var closeButton:Bool = false
    @objc open var closeButtonCallback:(()->Void)?
    @discardableResult @objc open func show(animated: Bool = true,parentView:UIView? = nil,_ callback:HUDCallback? = nil)->HUDItem {
        return HUD.shared.show(item: self, animated:animated, parentView: parentView, callback)
    }
    @objc open func hide(animated:Bool = true,callback:HUDCallback?) {
        if HUD.shared.currentItem == self {
            HUD.shared.hide(animated: animated) {
                callback?()
            }
        }
     }
    open func resume() {
        
    }
    open func resign() {
         
    }
}
open class HUD: UIView {
    @objc public static let shared:HUD = HUD()
    @IBOutlet private var title:UITextField!
    @IBOutlet public var itemContainer:UIView!
    @IBOutlet private var cover:UIView!
    @IBOutlet private var containerSize:NSLayoutConstraint!
    @IBOutlet public var closeButton:UIButton!
    @IBOutlet private var titleBackground:UIView!
    private var subView:UIView?
    @objc public var currentItem:HUDItem?
    public static var ignoreSameItemNames:Bool = true
    init() {
        super.init(frame: CGRect.zero)
        self.subView = (Bundle(for: type(of: self)).loadNibNamed("HUD", owner: self, options: nil))!.last as? UIView
        self.addSubview(subView!)
        NotificationCenter.default.addObserver(self, selector: #selector(handleOrientation), name:   NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    @objc func handleOrientation() {
        setNeedsLayout()
    }
    override open func layoutSubviews() {
        super.layoutSubviews()
        if let superView = self.superview {
            frame = superView.bounds
            subView?.frame = bounds
            let maxSize = max(superView.width,superView.height) * 2.0
            cover.size = CGSize(width:maxSize,height:maxSize)
            cover.center = superView.center
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    @discardableResult open func show(item:HUDItem,animated: Bool = true,parentView:UIView? = nil,_ callback:HUDCallback? = nil)->HUDItem {
        if HUD.ignoreSameItemNames && currentItem != nil && currentItem!.name != nil && item.name != nil && currentItem!.name == item.name! {
            callback?()
            return currentItem!
        }
        hide(animated: false)
        //{
            self.currentItem = item
            let targetView = parentView ?? (UIApplication.shared.keyWindow?.rootViewController?.view)!
            self.frame = targetView.frame
            self.title.text = item.title ?? "";
            self.closeButton.isHidden = !item.closeButton
        
            self.title.backgroundColor = item.titleBackgroundColor
            //Cover
            self.cover.backgroundColor = item.coverColor
            self.cover.alpha = item.coverAlpha
            self.cover.isHidden = !item.showCover
        
            self.titleBackground.isHidden = !(self.title != nil && self.title.text!.count > 0)
            self.isUserInteractionEnabled =    !self.cover.isHidden || !closeButton.isHidden
            targetView.addSubview(self)
            item.resume()
            item.size = self.itemContainer.size
            self.itemContainer.addSubview(item)
            //self.itemContainer.
           // let containerOriginalSize = self.containerSize.constant
            // self.containerSize.constant = containerOriginalSize
        
            self.alpha = 0
            UIView .animate(withDuration: animated ? 0.3 : 0.0, animations: {
                self.alpha = 1
            }, completion: { (completed) in
                
                callback?()
            });
       // }
        return item
    }
    @objc open func hide(name:String? = nil,animated:Bool = true,_ callback:HUDCallback? = nil) {
        if currentItem == nil {
            callback?()
            return
        }
        if name != nil && currentItem!.name != name {
            callback?()
            return
        }
        if(animated) {
            UIView .animate(withDuration: 0.3 * (animated ? 1 : 0 ), animations: {
                self.alpha = 0
            }, completion: { (completed) in
               
                self.removeFromSuperview()
                self.currentItem?.resign()
                self.currentItem?.removeSubViews()
                self.currentItem = nil
                callback?()
            });
        }
        else {
            self.removeFromSuperview()
            self.currentItem?.resign()
            self.currentItem?.removeSubViews()
            self.currentItem = nil
            callback?()
        }
    }
    @IBAction func closeButtonDidTapped(_ sender:UIButton) {
        currentItem?.closeButtonCallback?()
        self.hide()
    }
    static var HUDItemEmpty:HUDItem {
        let item = HUDItem()
        item.coverColor = UIColor.clear
        item.showCover = true
        return item
    }
}
