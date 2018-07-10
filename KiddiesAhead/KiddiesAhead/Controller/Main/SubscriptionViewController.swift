//
//  SubscriptionViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/1/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import SwiftyStoreKit
import Alamofire

class SubscriptionViewController: BaseViewController {

    @IBOutlet weak var ui_btnNext: UIButton!
    @IBOutlet weak var ui_btnBack: UIButton!
    @IBOutlet weak var ui_checkEn: UIImageView!
    @IBOutlet weak var ui_checkEs: UIImageView!
    @IBOutlet weak var ui_checkFr: UIImageView!
    @IBOutlet weak var ui_checkYb: UIImageView!
    @IBOutlet weak var ui_viewEn: UIView!
    @IBOutlet weak var ui_viewEs: UIView!
    @IBOutlet weak var ui_viewFr: UIView!
    @IBOutlet weak var ui_viewYb: UIView!
    @IBOutlet weak var ui_year: UIView!
    @IBOutlet weak var ui_month: UIView!
    @IBOutlet weak var ui_checkYear: UIImageView!
    @IBOutlet weak var ui_checkMonth: UIImageView!
    @IBOutlet weak var ui_lblPrice: UILabel!
    @IBOutlet weak var ui_lblEndDate: UILabel!
    
    var fromWhere = 0   // 0 : from profil, 1 : from signup
    var _isPurchasing = false
    
    let kYearProducts = [k1Lang1Year, k2Lang1Year, k3Lang1Year, k4Lang1Year]
    let kMonthProducts = [k1Lang1Month, k2Lang1Month, k3Lang1Month, k4Lang1Month]
    
    var _price : Double = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if fromWhere == 0 {
            ui_btnNext.isHidden = true
        } else {
            ui_btnBack.isHidden = true
        }
        
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
        
        let tapper5 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapYear(_:)))
        ui_year.addGestureRecognizer(tapper5)
        let tapper6 = UITapGestureRecognizer(target: self, action: #selector(self.handleTapMonth(_:)))
        ui_month.addGestureRecognizer(tapper6)
        
        ui_checkEn.isHighlighted = true
        ui_checkYear.isHighlighted = true
        
        calcPrice()
        calcEndDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func countSelected() -> Int {
        
        let langs = [ui_checkEn, ui_checkEs, ui_checkFr, ui_checkYb]
        var selected = 0
        
        for one in langs {
            if one!.isHighlighted {
                selected += 1
            }
        }
        
        return selected
    }
    
    func calcPrice() {
        
        let selected = countSelected()
        
        if ui_checkYear.isHighlighted {
            _price = Constants.YEARLY_PRICE[selected]
        } else {
            _price = Constants.MONTHY_PRICE[selected]
        }
        
        ui_lblPrice.text = "\(R.string.PRICE)£\(_price)"
    }
    
    func calcEndDate() {
        
        let currentDate = Date()
        
        var dateComponent = DateComponents()
        
        if ui_checkMonth.isHighlighted {
            dateComponent.month = 1
        } else {
            dateComponent.year = 1
        }
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        let result = formatter.string(from: futureDate!)
        
        ui_lblEndDate.text = "\(R.string.ENDDATE)\(result)"
    }
    
    @objc func handleTapLang(_ sender:LangTapGesture) {
        
        switch sender.lang {
        case "en":
            ui_checkEn.isHighlighted = !ui_checkEn.isHighlighted
        case "es":
            ui_checkEs.isHighlighted = !ui_checkEs.isHighlighted
        case "fr":
            ui_checkFr.isHighlighted = !ui_checkFr.isHighlighted
        case "yb":
            ui_checkYb.isHighlighted = !ui_checkYb.isHighlighted
        default:
            break
        }
        
        calcPrice()
    }
    
    @objc func handleTapYear(_ sender:LangTapGesture) {
        
        ui_checkYear.isHighlighted = true
        ui_checkMonth.isHighlighted = false
      
        calcEndDate()
        calcPrice()
    }
    
    @objc func handleTapMonth(_ sender:LangTapGesture) {
        
        ui_checkYear.isHighlighted = false
        ui_checkMonth.isHighlighted = true
        
        calcEndDate()
        calcPrice()
    }
    
    func purchase(_ productId : String) {
        
        // for test
        
        self.onSuccessPurchase()
        
        /*
        
        showHUD()
        _isPurchasing = true
        
        SwiftyStoreKit.purchaseProduct(productId, atomically: true, applicationUsername: R.string.APP_TITLE, completion: { result in

            switch result {

            case .success:
                self.onSuccessPurchase()
                break

            case .error(let error):
                self._isPurchasing = false
                self.hideHUD()
                self.showAlertDialog(title: R.string.APP_TITLE, message: error.localizedDescription, positive: R.string.OK, negative: nil)
                break
            }
        })
 
         */
        
    }
    
    func onSuccessPurchase() {
        
        var en_end : String?
        var es_end : String?
        var fr_end : String?
        var yb_end : String?
        
        var dateComponent = DateComponents()
        
        if ui_checkMonth.isHighlighted {
            dateComponent.month = 1
        } else {
            dateComponent.year = 1
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        if ui_checkEn.isHighlighted {
            
            var fromDate = Date()
            if let currentEnd = g_user._enEnd, currentEnd > fromDate {
                fromDate = currentEnd
            }
            
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: fromDate)
            g_user._enEnd = futureDate
            en_end = formatter.string(from: futureDate!)
        }
        
        if ui_checkEs.isHighlighted {
            
            var fromDate = Date()
            if let currentEnd = g_user._esEnd, currentEnd > fromDate {
                fromDate = currentEnd
            }
            
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: fromDate)
            g_user._esEnd = futureDate
            es_end = formatter.string(from: futureDate!)
        }
        
        if ui_checkFr.isHighlighted {
            
            var fromDate = Date()
            if let currentEnd = g_user._frEnd, currentEnd > fromDate {
                fromDate = currentEnd
            }
            
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: fromDate)
            g_user._frEnd = futureDate
            fr_end = formatter.string(from: futureDate!)
        }
        
        if ui_checkYb.isHighlighted {
            
            var fromDate = Date()
            if let currentEnd = g_user._ybEnd, currentEnd > fromDate {
                fromDate = currentEnd
            }
            
            let futureDate = Calendar.current.date(byAdding: dateComponent, to: fromDate)
            g_user._ybEnd = futureDate
            yb_end = formatter.string(from: futureDate!)
        }
        
        ApiManager.sharedManager.subscribe(userId: g_user._id, price: _price, en_end: en_end, es_end: es_end, fr_end: fr_end, yb_end: yb_end) { (success, data) in
            
            self._isPurchasing = false
            self.hideHUD()
            
        }
    }
    
    func gotoHome() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        vc.fromSubscription = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func onPurchase(_ sender: Any) {
        
        if _isPurchasing {
            return
        }
        
        let selected = countSelected()
        if selected == 0 {
            showAlertDialog(title: R.string.APP_TITLE, message: R.string.SELECT_LANGUAGE, positive: R.string.OK, negative: nil)
            return
        }
        
        var productId = ""
        if ui_checkMonth.isHighlighted {
            productId = kMonthProducts[selected - 1]
        } else {
            productId = kYearProducts[selected - 1]
        }
        
        purchase(productId)
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onNext(_ sender: Any) {
        gotoHome()
    }
    
}


class LangTapGesture: UITapGestureRecognizer {
    var lang = String()
}
