//
//  SettingViewController.swift
//  KiddiesAhead
//
//  Created by sts on 3/3/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyUserDefaults

class SettingViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UITextFieldDelegate  {

    @IBOutlet weak var ui_collection: UICollectionView!
    @IBOutlet weak var ui_txvHours: UITextField!
    @IBOutlet weak var ui_viewPwd: UIView!
    @IBOutlet weak var ui_txvCurrent: UITextField!
    @IBOutlet weak var ui_txvNew: UITextField!
    @IBOutlet weak var ui_txvConfirm: UITextField!
    
    @IBOutlet weak var ui_card0: UIView!
    @IBOutlet weak var ui_card1: UIView!
    @IBOutlet weak var ui_card2: UIView!
    @IBOutlet weak var ui_card3: UIView!
    
    @IBOutlet weak var ui_check0: UIImageView!
    @IBOutlet weak var ui_check1: UIImageView!
    @IBOutlet weak var ui_check2: UIImageView!
    @IBOutlet weak var ui_check3: UIImageView!
    
    var categories = [CategoryModel]()
    let CATEGORY_NAMES = [R.string.CATEGORY_1, R.string.CATEGORY_2, R.string.CATEGORY_3,
                          R.string.CATEGORY_4, R.string.CATEGORY_5, R.string.CATEGORY_6, R.string.CATEGORY_7,
                          R.string.CATEGORY_8, R.string.CATEGORY_9, R.string.CATEGORY_10, R.string.CATEGORY_11,
                          R.string.CATEGORY_12, R.string.CATEGORY_13, R.string.CATEGORY_14, R.string.CATEGORY_15,
                          R.string.CATEGORY_16, R.string.CATEGORY_17]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cat_selected = Defaults[.categories]

        for i in 0..<CATEGORY_NAMES.count {
            let cat = CategoryModel(name: CATEGORY_NAMES[i])
            
            if cat_selected != nil {
                cat.selected = cat_selected![i]
            }
            
            categories.append(cat)
        }
        
        if Defaults[.hours] == nil {
            Defaults[.hours] = Constants.HOURSWEEK
        }
        
        ui_txvHours.text = "\(Defaults[.hours]!)"
        
        if Defaults[.cards] == nil {
            
            if g_user._age == 0 {
                Defaults[.cards] = 1
            } else {
                Defaults[.cards] = 2
            }
        }
        
        loadCardNumber()
        
        ui_viewPwd.isHidden = true
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(self.handleTapView(_:)))
        self.ui_viewPwd.addGestureRecognizer(tapper)
        
        ui_txvCurrent.attributedPlaceholder = NSAttributedString(string: R.string.CURRENT_PWD,
                                                               attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        ui_txvNew.attributedPlaceholder = NSAttributedString(string: R.string.NEW_PWD,
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        ui_txvConfirm.attributedPlaceholder = NSAttributedString(string: R.string.CONFIRM_PWD2,
                                                             attributes: [NSAttributedStringKey.foregroundColor: UIColor.white])
        
        setupTap()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.sharedManager().enableAutoToolbar = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        IQKeyboardManager.sharedManager().enableAutoToolbar = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTap() {
        
        let views = [ui_card0, ui_card1, ui_card2, ui_card3]
        
        for view in views {
            let tapper1 = CardsTapGesture(target: self, action: #selector(self.handleTapCards(_:)))
            tapper1.number = view!.tag
            view!.addGestureRecognizer(tapper1)
        }
        
    }
    
    func loadCardNumber() {
        
        let views = [ui_check0, ui_check1, ui_check2, ui_check3]
        
        for view in views {
            view!.isHighlighted = false
        }
        
        views[Defaults[.cards]!]!.isHighlighted = true
        
    }
    
    @objc func handleTapCards(_ sender:CardsTapGesture) {
        
        let views = [ui_check0, ui_check1, ui_check2, ui_check3]
        
        for view in views {
            view!.isHighlighted = false
        }
        
        views[sender.number]!.isHighlighted = true
        Defaults[.cards] = sender.number
        
    }
    
    func checkValid() -> Bool {
        
        if (ui_txvCurrent.text?.trimmed.isEmpty)! {
            
            showError(R.string.INPUT_CURRENTPWD)
            return false
        }
       
        if (ui_txvNew.text?.trimmed.isEmpty)! {
            
            showError(R.string.INPUT_NEWPWD)
            return false
        }
        
        if ui_txvConfirm.text?.trimmed != ui_txvNew.text?.trimmed {
            
            showError(R.string.CONFIRM_PWD)
            return false
        }
        
        if ui_txvCurrent.text?.trimmed != Defaults[.pwd] {
            showError(R.string.WRONG_PWD2)
            return false
        }
        
        return true
    }
    
    func resetPwd() {
        
        showHUD()
        
        ApiManager.sharedManager.setPassword(user_id: g_user._id, password: (ui_txvNew.text?.trimmed)!) { (success, data) in
            
            self.hideHUD()
            
            if (success) {
                Defaults[.pwd] = self.ui_txvNew.text?.trimmed
                self.ui_viewPwd.isHidden = true
                self.showAlertDialog(title: R.string.APP_TITLE, message: R.string.PWD_CHANGED, positive: R.string.OK, negative: nil)
            } else {
                self.showError(R.string.ERROR_OCCURED)
                
            }
        }
        
    }
    
    
    @IBAction func onChangePwd(_ sender: Any) {
        
        ui_viewPwd.isHidden = false
    }
    @IBAction func onResetPwd(_ sender: Any) {
        
        if checkValid() {
            resetPwd()
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        
        Defaults[.email] = nil
        Defaults[.pwd] = nil
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }
    
    @IBAction func onBack(_ sender: Any) {
        
        var cat_selected = [Bool]()
        for one in categories {
            cat_selected.append(one.selected)
        }
        
        Defaults[.categories] = cat_selected
        
        self.navigationController?.popViewController(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.item
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopicCell", for: indexPath) as! TopicCell
        
        cell.ui_lblName.text = categories[index].name
        cell.ui_imvIcon.image = UIImage(named:"cat_\(index)")
        cell.ui_imvCheck.isHighlighted = categories[index].selected
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
       categories[indexPath.item].selected = !categories[indexPath.item].selected
        ui_collection.reloadItems(at: [indexPath])
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.size
        
        let w = (screenSize.width - 100) / 4 - 8;
        let size = CGSize(width: w, height: w / 4)
        
        return size
    }
    
    @IBAction func OnEndEditing(_ sender: Any) {
        if (ui_txvHours.text?.isEmpty)! {
            ui_txvHours.text = "0"
        }
        
        Defaults[.hours] = Int(ui_txvHours.text!)!
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == ui_txvHours {
        
            let maxLength = 2
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =
                currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
            
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if (textField == ui_txvCurrent) {
            _ = ui_txvNew.becomeFirstResponder()
        } else if (textField == ui_txvNew) {
            _ = ui_txvConfirm.becomeFirstResponder()
        }
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    @objc func handleTapView(_ sender:UITapGestureRecognizer) {
        
        if !ui_txvCurrent.isFirstResponder && !ui_txvNew.isFirstResponder && !ui_txvConfirm.isFirstResponder {
            ui_viewPwd.isHidden = true
        } else {
            self.view.endEditing(true);
        }
    }
}

class CardsTapGesture: UITapGestureRecognizer {
    var number = 0
}
