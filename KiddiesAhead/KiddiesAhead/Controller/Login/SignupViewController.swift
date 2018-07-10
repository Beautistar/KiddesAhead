//
//  LoginViewController.swift
//  KiddiesAhead
//
//  Created by sts on 3/30/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SwiftyUserDefaults

class SignUpViewController: BaseViewController,  UITextFieldDelegate  {
    
    @IBOutlet weak var ui_txvEmail: UITextField!
    @IBOutlet weak var ui_txvPwd: UITextField!
    @IBOutlet weak var ui_txvUsername: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapper = UITapGestureRecognizer(target: self, action: #selector(self.handleTapView(_:)))
        self.view.addGestureRecognizer(tapper)
        
        ui_txvEmail.attributedPlaceholder = NSAttributedString(string: R.string.EMAIL,
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        ui_txvUsername.attributedPlaceholder = NSAttributedString(string: R.string.USERNAME,
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        ui_txvPwd.attributedPlaceholder = NSAttributedString(string: R.string.PASSWORD,
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkValid() -> Bool {
        
        if (ui_txvEmail.text?.trimmed.isEmpty)! {
            
            showError(R.string.INPUT_EMAIL)
            return false
        }
        
        if !isValidEmail((ui_txvEmail.text?.trimmed)!) {
            
            showError(R.string.INVALID_EMAIL)
            return false
        }
        
        if (ui_txvUsername.text?.trimmed.isEmpty)! {
            
            showError(R.string.INPUT_USERNAME)
            return false
        }
        
        if (ui_txvPwd.text?.trimmed.isEmpty)! {
            
            showError(R.string.INPUT_PWD)
            return false
        }
        
        return true
    }
    
    func signUp() {
        
        if !checkValid() {
            return
        }
        
        showHUD()
        
        ApiManager.sharedManager.signup(email: (ui_txvEmail.text?.trimmed)!, username: (ui_txvUsername.text?.trimmed)!, pwd: (ui_txvPwd.text?.trimmed)!) { (success, data) in
            
            self.hideHUD()
            
            if (success) {
                self.onSuccessSignUp()
            } else {
                if data == nil {
                    self.showError(R.string.CONNECT_FAIL)
                } else {
                    self.showError(R.string.USEREMAIL_EXIST)
                }
            }
        }
        
    }

    
    func onSuccessSignUp() {
        
        if Defaults[.granted] {
            gotoSubscription()
        } else {
            gotoAllow()
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        signUp()
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func gotoSubscription() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionViewController") as! SubscriptionViewController
        vc.fromWhere = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoAllow() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllowMicViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == ui_txvEmail) {
            _ = ui_txvUsername.becomeFirstResponder()
        } else if (textField == ui_txvUsername) {
            _ = ui_txvPwd.becomeFirstResponder()
        }

        textField.resignFirstResponder()
        
        return true
    }
    
    
    @objc func handleTapView(_ sender:UITapGestureRecognizer) {
        
        self.view.endEditing(true);
    }

}
