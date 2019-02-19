//
//  ViewController.swift
//  TestFramework
//
//  Created by Alon Genosar on 09/01/2019.
//  Copyright © 2019 Snappers. All rights reserved.
//

import UIKit
import SnappersSDK
class ViewController: UIViewController,UITextFieldDelegate,CLLocationManagerDelegate {
    @IBOutlet var presentationMethod:UISegmentedControl!
    @IBOutlet var stackTopConstraint:NSLayoutConstraint!
    @IBOutlet var eventIFTF:UITextField! { didSet { eventIFTF.delegate = self } }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        eventIFTF.text = UserDefaults.standard.value(forKey: "eventId") as? String ?? ""
        
        //Twittewr
        //        Twitter.sharedInstance().start(withConsumerKey: "Uglk6Y3L9gBLeWapKPFtVxHsq", consumerSecret: "BsW84cgCKWSabrxJXtHqFDMjIuAFTHBWu8YthqaJHwW7YOzJDD")
        //        let twitterButton = TWTRLogInButton()
        //        twitterButton.sendActions(for: .touchUpInside)
        //        twitterButton.logInCompletion = { session, error in
        //           // print("result",session,error)
        //        }
        //        view.addSubview(twitterButton)
        //        twitterButton.center = view.center
        //Facebook
        // let button = FBSDKLoginButton()
        // button.center = view.center
        // view.addSubview(button)
    }
    @IBAction func didTapInitSDK(_ sender:UIButton) {
        HUDItemActivity().show()
        // #error("Please enter API token and secret below, then delete this line.")
        /*   "GOSK-D044-0100-E462-C490-FF81"*/
        SnappersSDK.shared.identify(token: "abcde"/*"goCNN"*/, secret: "GOSK-F243-0100-05CF-48E0-86DD") { error in
            
            
            if let error = error {
                Drop.down(error.domain,state: .error)
            }
            else {
                Drop.down("Logged in Succssfully",state: .info)
            }
            HUD.shared.hide()
        }
    }
    @IBAction func didTapLogout(_ sender:UIButton) {
        HUDItemActivity().show()
        SnappersSDK.shared.logout() { error in
            if let error = error {
                Drop.down(error.domain,state: .error)
            }
            else {
                Drop.down("Logged out Succssfully",state: .info)
            }
            HUD.shared.hide()
        }
    }
    @IBAction func didTapFacebookLogin(_ sender:UIButton) {
        HUDItemActivity().show()
        SnappersSDK.shared.login(method: .facebook){ error in
            if let error = error {
                Drop.down(error.domain,state: .error)
            }
            else {
                Drop.down("Logged in Succssfully",state: .info)
            }
            HUD.shared.hide()
        }
    }
    @IBAction func didTapTwitterLogin(_ sender:UIButton) {
        HUDItemActivity().show()
        SnappersSDK.shared.login(method: .twitter) { error in
            if let error = error {
                Drop.down(error.domain,state: .error)
            }
            else {
                Drop.down("Logged in Succssfully",state: .info)
            }
            HUD.shared.hide()
        }
    }
    //
    // request a broadcast invitation notification
    //
    @IBAction func didTapRequestInvitation(_ sender:UIButton) {
        view.endEditing(true)
        HUDItemActivity().show()
        if let eventId = eventIFTF.text {
            let delay = 5 as TimeInterval
            UserDefaults.standard.setValue(eventId, forKeyPath: "eventId")
            SnappersSDK.shared.requestBroadcastInvitation(eventId: eventId,delay:delay)  { error in
                if error != nil {
                    Drop.down(error!.domain,state: .error,duration: delay)
                } else {
                    Drop.down("Invitation shoud be recived in \(delay) seconds",state: .info)
                }
                HUD.shared.hide()
            }
        }
    }
    @IBAction func didTapShowMapView(_ sender:UIButton) {
        view.endEditing(true)
        HUDItemActivity().show()
        if let eventId = eventIFTF.text {
            UserDefaults.standard.setValue(eventId, forKeyPath: "eventId")
        }
        SnappersSDK.shared.present(SnappersView.map) { error in
            if let error = error {
                Drop.down(error.domain,state: .error)
            }
            HUD.shared.hide()
        }
    }
    @IBAction func didTapShowEventListView(_ sender:UIButton) {
        view.endEditing(true)
        // HUDItemActivity().show()
        if let eventId = eventIFTF.text {
            UserDefaults.standard.setValue(eventId, forKeyPath: "eventId")
        }
        SnappersSDK.shared.present(SnappersView.eventList) { error in
            if let error = error {
                Drop.down(error.domain,state: .error)
            }
            HUD.shared.hide()
        }
    }
    //handle textfield events
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        UserDefaults.standard.setValue( eventIFTF.text, forKeyPath: "eventId")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    //handle keyboard events
    @objc func keyboardWillShow(notification: Notification) {
        let keyboardHeight = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! CGRect).size.height
        let keyboardDuration   = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
        UIView.animate(withDuration: keyboardDuration!) {
            
            self.stackTopConstraint.constant = CGFloat(keyboardHeight)
            self.view.layoutIfNeeded()
        }
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        let keyboardDuration   = notification.userInfo![UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval
        UIView.animate(withDuration: keyboardDuration ?? 0) {
            self.stackTopConstraint.constant = 0
            self.view.layoutIfNeeded()
        }
    }
}
