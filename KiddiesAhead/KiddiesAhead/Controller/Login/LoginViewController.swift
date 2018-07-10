//
//  LoginViewController.swift
//  KiddiesAhead
//
//  Created by sts on 3/30/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyUserDefaults
import SwiftyJSON

class LoginViewController: BaseViewController,  UITextFieldDelegate  {
    
    @IBOutlet weak var ui_txvEmail: UITextField!
    @IBOutlet weak var ui_txvPwd: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapper = UITapGestureRecognizer(target: self, action: #selector(self.handleTapView(_:)))
        self.view.addGestureRecognizer(tapper)
        
        ui_txvEmail.attributedPlaceholder = NSAttributedString(string: R.string.EMAIL,
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
        
        if (ui_txvPwd.text?.trimmed.isEmpty)! {
            
            showError(R.string.INPUT_PWD)
            return false
        }
        
        return true
    }
    
    func login() {
        
        if !checkValid() {
            return
        }
        
        showHUD()
        
        ApiManager.sharedManager.login(email: (ui_txvEmail.text?.trimmed)!, pwd: (ui_txvPwd.text?.trimmed)!) { (success, data) in
            
            self.hideHUD()
            
            if (success) {
                self.onSuccessLogin()
            } else {
                if data == nil {
                    self.showError(R.string.CONNECT_FAIL)
                } else {
                    
                    let code = data as! Int
                    
                    if code == 104 {
                        self.showError(R.string.USER_NOTEXIST)
                    } else if code == 105 {
                        self.showError(R.string.WRONG_PWD)
                    } else {
                        self.showError(R.string.ERROR_OCCURED)
                    }
                }
            }
        }
        
    }
    
    func onSuccessLogin() {
        
        if Defaults[.granted] {
            gotoHome()
        } else {
            gotoAllow()
        }
    }
    
    func onSuccessPassword() {
        showAlertDialog(title: R.string.APP_TITLE, message: R.string.SENT_MAIL, positive: R.string.OK, negative: nil)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        login()
    }
    
    
    @IBAction func onForgot(_ sender: Any) {
        
        if (ui_txvEmail.text?.trimmed.isEmpty)! {
            
            showError(R.string.INPUT_EMAIL)
            return
        }
        
        if !isValidEmail((ui_txvEmail.text?.trimmed)!) {
            
            showError(R.string.INVALID_EMAIL)
            return
        }
        
        showHUD()
        
        ApiManager.sharedManager.resetPassword(email: (ui_txvEmail.text?.trimmed)!) { (success, data) in
            
            self.hideHUD()
            
            if (success) {
                self.onSuccessPassword()
            } else {
                if data == nil {
                    self.showError(R.string.CONNECT_FAIL)
                } else {
                    
                    let code = data as! Int
                    
                    if code == 104 {
                        self.showError(R.string.USER_NOTEXIST)
                    } else {
                        self.showError(R.string.ERROR_OCCURED)
                    }
                }
            }
        }
    }
    
    @IBAction func onSignUp(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func gotoAllow() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllowMicViewController") as! AllowMicViewController
        vc.fromLogin = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoHome() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == ui_txvEmail) {
            _ = ui_txvPwd.becomeFirstResponder()
        }

        textField.resignFirstResponder()
        
        return true
    }
    
    
    @objc func handleTapView(_ sender:UITapGestureRecognizer) {
        
        self.view.endEditing(true);
    }

}
