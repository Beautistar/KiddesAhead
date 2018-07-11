//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class BedroomPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "bedroom",          // 0
        "bed",              // 1
        "window",           // 2
        "rug",              // 3
        "wardrobe",         // 4
        "clock",            // 5
        "flower",           // 6
        "table",            // 7
        "lamp",             // 8
        "chair",            // 9
        "shoes",            // 10
        "bear",             // 11
        "socks",            // 12
        "picture",          // 13
        "table",            // 14
        "tv" ,              // 15
        "flower"            // 16
        
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.words = WORDS
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBack(_ sender: Any) {
        back()
    }

}
