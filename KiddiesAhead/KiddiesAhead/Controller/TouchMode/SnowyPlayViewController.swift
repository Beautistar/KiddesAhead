//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class SnowyPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "snow",        // 0
        "house",         // 1
        "tree",         // 2
        "igloo",         // 3
        "snowman",         // 4
        "igloo",        // 5
        "snowman",        // 6
        "boy",          // 7
        "penguin",         // 8
        "seal"          // 9
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
