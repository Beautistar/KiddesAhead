//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class RainyPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "rain",        // 0
        "thunder",         // 1
        "cloud",         // 2
        "grass",         // 3
        "log",         // 4
        "frog",        // 5
        "grass",        // 6
        "flower",          // 7
        "flower",         // 8
        "flower",         // 9
        "frog"     // 10
        
    ]
    
    let BACK_WORDS = [
        "lake"      // 300
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.words = WORDS
        self.backWords = BACK_WORDS
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBack(_ sender: Any) {
        back()
    }

}
