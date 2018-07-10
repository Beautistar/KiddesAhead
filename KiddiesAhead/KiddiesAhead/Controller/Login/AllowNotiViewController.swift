//
//  AllowNotiViewController.swift
//  KiddiesAhead
//
//  Created by sts on 3/31/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import UserNotifications
import SwiftyUserDefaults

class AllowNotiViewController: UIViewController {
    
    var fromLogin = false;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoSubscription() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionViewController") as! SubscriptionViewController
        vc.fromWhere = 1
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoHome() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onAllow(_ sender: Any) {
        
        let center = UNUserNotificationCenter.current()
        center.delegate = UIApplication.shared.delegate! as? UNUserNotificationCenterDelegate
        // set the type as sound or badge
        center.requestAuthorization(options: [.sound,.alert,.badge]) { (granted, error) in
            if granted {
                print("Notification Enable Successfully")
            }else{
                print("Some Error Occure")
            }
            
            Defaults[.granted] = true
            
            DispatchQueue.main.async(execute:  {
                
                if self.fromLogin {
                    self.gotoHome()
                } else {
                    self.gotoSubscription()
                }
            })
            
        }
    }
    

}
