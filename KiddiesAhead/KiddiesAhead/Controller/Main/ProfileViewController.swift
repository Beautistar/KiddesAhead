//
//  ProfileViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/1/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import SwiftyUserDefaults
import Alamofire

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var ui_lblName: UILabel!
    @IBOutlet weak var ui_checkEn: UIImageView!
    @IBOutlet weak var ui_checkEs: UIImageView!
    @IBOutlet weak var ui_checkFr: UIImageView!
    @IBOutlet weak var ui_checkYb: UIImageView!
    @IBOutlet weak var ui_viewEn: UIView!
    @IBOutlet weak var ui_viewEs: UIView!
    @IBOutlet weak var ui_viewFr: UIView!
    @IBOutlet weak var ui_viewYb: UIView!
    
    @IBOutlet weak var ui_checkEn2: UIImageView!
    @IBOutlet weak var ui_checkEs2: UIImageView!
    @IBOutlet weak var ui_checkFr2: UIImageView!
    @IBOutlet weak var ui_checkYb2: UIImageView!
    @IBOutlet weak var ui_viewEn2: UIView!
    @IBOutlet weak var ui_viewEs2: UIView!
    @IBOutlet weak var ui_viewFr2: UIView!
    @IBOutlet weak var ui_viewYb2: UIView!

    @IBOutlet weak var ui_viewAttend: UIView!
    @IBOutlet weak var ui_checkAttend: UIImageView!
    
    @IBOutlet weak var ui_viewAge0: UIView!
    @IBOutlet weak var ui_viewAge1: UIView!
    @IBOutlet weak var ui_checkAge0: UIImageView!
    @IBOutlet weak var ui_checkAge1: UIImageView!
    @IBOutlet weak var ui_lblDate: UILabel!
    @IBOutlet weak var ui_lblSpent: UILabel!
    
    var isChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ui_lblName.text = g_user._username.uppercased()
        
        updateNativeLang()
        updateLearningLang()
        updateAge()
        
        setupTap()
        setupTap2()
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(self.handleTapAttend(_:)))
        ui_viewAttend.addGestureRecognizer(tapper)
        ui_checkAttend.isHighlighted = g_user._attend
        
        let tapper1 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapAge1(_:)))
        ui_viewAge0.addGestureRecognizer(tapper1)
        let tapper2 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapAge2(_:)))
        ui_viewAge1.addGestureRecognizer(tapper2)
        
        showDate()
        
        showSpent()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showSpent() {
        
        let current = Date()
        let spent = current.timeIntervalSince1970 - g_start
        let mins = Int(spent / 60.0) + 1 + g_user._spentMins
        let hours = Int(mins / 60)
        
        let result = NSMutableAttributedString(string: R.string.SPENT)
        
        let timeAttr = [NSAttributedStringKey.foregroundColor : UIColor(red: 255 / 255.0, green: 120 / 255.0, blue: 0 / 255.0, alpha: 1.0)]
        var time = NSMutableAttributedString()
        var spentStr = NSMutableAttributedString()
        if hours > 0 {
            time = NSMutableAttributedString(string:"\(hours)", attributes:timeAttr)
            spentStr = NSMutableAttributedString(string:R.string.HOURSTHISWEEK)
        } else {
            time = NSMutableAttributedString(string:"\(mins)",  attributes:timeAttr)
            spentStr = NSMutableAttributedString(string:R.string.MINSTHISWEEK)
        }
        
        result.append(time)
        result.append(spentStr)
        
        if Defaults[.hours] == nil {
            Defaults[.hours] = Constants.HOURSWEEK
        }
        
        let perWeek = Defaults[.hours]!
        let leftHours = perWeek - hours
        
        if leftHours > 0 {
            time = NSMutableAttributedString(string:"\(leftHours)", attributes:timeAttr)
            result.append(time)
            result.append(NSMutableAttributedString(string:R.string.HOURSLEFT))
        } else {
            result.append(NSMutableAttributedString(string:R.string.HOURSCOMPLETE))
        }
        
        ui_lblSpent.attributedText = result
        
    }
    
    func showDate() {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        
        
        var date : Date?
        
        if ui_checkEn2.isHighlighted {
            date = g_user._enEnd
        } else if ui_checkEs2.isHighlighted {
            date = g_user._esEnd
        } else if ui_checkFr2.isHighlighted {
            date = g_user._frEnd
        } else if ui_checkYb2.isHighlighted {
            date = g_user._ybEnd
        }
        
        if date != nil {
            ui_lblDate.text = formatter.string(from: date!)
            
            if date! < Date() {
                ui_lblDate.text! += R.string.EXPIRED
            }
            
        } else {
            ui_lblDate.text = R.string.NOTAVILABLE
        }
    }
    
    func setupTap() {
        
        let tapper1 = LangTapGesture(target: self, action: #selector(self.handleTapLang(_:)))
        tapper1.lang = "en"
        ui_viewEn.addGestureRecognizer(tapper1)
        
        let tapper2 = LangTapGesture(target: self, action: #selector(self.handleTapLang(_:)))
        tapper2.lang = "es"
        ui_viewEs.addGestureRecognizer(tapper2)
        
        let tapper3 = LangTapGesture(target: self, action: #selector(self.handleTapLang(_:)))
        tapper3.lang = "fr"
        ui_viewFr.addGestureRecognizer(tapper3)
        
        let tapper4 = LangTapGesture(target: self, action: #selector(self.handleTapLang(_:)))
        tapper4.lang = "yb"
        ui_viewYb.addGestureRecognizer(tapper4)
    }
    
    @objc func handleTapLang(_ sender:LangTapGesture) {
        
        Defaults[.native] = sender.lang
        updateNativeLang()

    }
    
    func updateNativeLang() {
        
        if Defaults[.native] == nil {
            Defaults[.native] = "en"
        }
        
        ui_checkEn.isHighlighted = Defaults[.native]! == "en"
        ui_checkEs.isHighlighted = Defaults[.native]! == "es"
        ui_checkFr.isHighlighted = Defaults[.native]! == "fr"
        ui_checkYb.isHighlighted = Defaults[.native]! == "yb"
    }
    
    func setupTap2() {
        
        let tapper1 = LangTapGesture(target: self, action: #selector(self.handleTapLang2(_:)))
        tapper1.lang = "en"
        ui_viewEn2.addGestureRecognizer(tapper1)
        
        let tapper2 = LangTapGesture(target: self, action: #selector(self.handleTapLang2(_:)))
        tapper2.lang = "es"
        ui_viewEs2.addGestureRecognizer(tapper2)
        
        let tapper3 = LangTapGesture(target: self, action: #selector(self.handleTapLang2(_:)))
        tapper3.lang = "fr"
        ui_viewFr2.addGestureRecognizer(tapper3)
        
        let tapper4 = LangTapGesture(target: self, action: #selector(self.handleTapLang2(_:)))
        tapper4.lang = "yb"
        ui_viewYb2.addGestureRecognizer(tapper4)
    }
    
    @objc func handleTapLang2(_ sender:LangTapGesture) {
        
        Defaults[.learning] = sender.lang
        updateLearningLang()
        showDate()
    }
    
    func updateLearningLang() {
        
        if Defaults[.learning] == nil {
            Defaults[.learning] = "en"
        }

        ui_checkEn2.isHighlighted = Defaults[.learning]! == "en"
        ui_checkEs2.isHighlighted = Defaults[.learning]! == "es"
        ui_checkFr2.isHighlighted = Defaults[.learning]! == "fr"
        ui_checkYb2.isHighlighted = Defaults[.learning]! == "yb"

    }
    
    @objc func handleTapAttend(_ sender:UITapGestureRecognizer) {
        g_user._attend = !g_user._attend
        ui_checkAttend.isHighlighted = g_user._attend
        
        isChanged = true
    }
    
    @objc func handleTapAge1(_ sender:UITapGestureRecognizer) {
        g_user._age = 0
        updateAge()
        
        isChanged = true
    }
    
    @objc func handleTapAge2(_ sender:UITapGestureRecognizer) {
        g_user._age = 1
        updateAge()
        
        isChanged = true
    }
    
    func updateAge() {
        ui_checkAge0.isHighlighted = g_user._age == 0
        ui_checkAge1.isHighlighted = g_user._age == 1
    }
    
    func saveProfile() {
        
        if !isChanged {
            return
        }
        
        var attend = 0
        if g_user._attend {
            attend = 1
        }
        
        ApiManager.sharedManager.saveProfile(userId:g_user._id, age:g_user._age, attend:attend) { (success, data) in

        }
    }
    
    @IBAction func onSubscribe(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionViewController") as! SubscriptionViewController
        vc.fromWhere = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func onBack(_ sender: Any) {
        self.saveProfile()
        self.navigationController?.popViewController(animated: true)
    }

}
