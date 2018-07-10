//
//  BaseViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/6/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func showAlertDialog(title: String!, message: String!, positive: String?, negative: String?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if (positive != nil) {
            
            alert.addAction(UIAlertAction(title: positive, style: .default, handler: nil))
        }
        
        if (negative != nil) {
            
            alert.addAction(UIAlertAction(title: negative, style: .default, handler: nil))
        }
        
        DispatchQueue.main.async(execute:  {
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func showError(_ message: String!) {
        
        showAlertDialog(title: R.string.ERROR, message: message, positive: R.string.OK, negative: nil)
    }
    
    func showHUD() {
        
        showHUDWithTitle(title: "")
    }
    
    func showHUDWithTitle(title: String) {
        
        if title == "" {
            
            ProgressHUD.show()
            
        } else {
            
            ProgressHUD.showWithStatus(string: title)
        }
    }
    
    func showSuccess() {
        
        DispatchQueue.main.async(execute:  {
            ProgressHUD.showSuccessWithStatus(string: R.string.SUCCESS)
        })
        
    }
    
    // hide loading view
    func hideHUD() {
        
        ProgressHUD.dismiss()
    }

}

extension DefaultsKeys {
    
    static let email = DefaultsKey<String?>("email")
    static let pwd = DefaultsKey<String?>("pwd")
    static let token = DefaultsKey<String?>("token")
    static let granted = DefaultsKey<Bool>("granted")
    static let native = DefaultsKey<String?>("native")
    static let learning = DefaultsKey<String?>("learning")
    static let hours = DefaultsKey<Int?>("hours")
    static let categories = DefaultsKey<[Bool]?>("categories")
    static let cards = DefaultsKey<Int?>("cards")
    static let speed = DefaultsKey<Int?>("speed")
    
}

extension String {
    /**
     :name:    trim
     */
    public var trimmed: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    /**
     :name:    lines
     */
    public var lines: [String] {
        return components(separatedBy: CharacterSet.newlines)
    }
    
    /**
     :name:    firstLine
     */
    public var firstLine: String? {
        return lines.first?.trimmed
    }
    
    /**
     :name:    lastLine
     */
    public var lastLine: String? {
        return lines.last?.trimmed
    }
    
    /**
     :name:    replaceNewLineCharater
     */
    public func replaceNewLineCharater(separator: String = " ") -> String {
        return components(separatedBy: CharacterSet.whitespaces).joined(separator: separator).trimmed
    }
    
    /**
     :name:    replacePunctuationCharacters
     */
    public func replacePunctuationCharacters(separator: String = "") -> String {
        return components(separatedBy: CharacterSet.punctuationCharacters).joined(separator: separator).trimmed
    }
}
