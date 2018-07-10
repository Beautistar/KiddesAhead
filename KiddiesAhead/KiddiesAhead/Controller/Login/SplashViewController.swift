//
//  SplashViewController.swift
//  KiddiesAhead
//
//  Created by sts on 3/3/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyUserDefaults

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        checkLogin()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkLogin() {
        
        if let email = Defaults[.email], let pwd = Defaults[.pwd] {
            login(email:email, pwd:pwd)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.gotoLogin()
            })
        }
    }
    
    func login(email : String, pwd : String) {
        
        ApiManager.sharedManager.login(email: email, pwd: pwd) { (success, data) in
            
            if (success) {
                self.gotoHome()
            } else {
                self.gotoLogin()
            }
        }
        
    }
    
    func gotoHome() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }

    func gotoLogin() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}
