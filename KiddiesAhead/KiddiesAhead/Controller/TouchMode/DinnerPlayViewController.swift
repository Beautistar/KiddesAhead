//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class DinnerPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "dinner",        // 0
        "window",         // 1
        "window",         // 2
        "window",         // 3
        "table",         // 4
        "chair",        // 5
        "chair",        // 6
        "hamburger",          // 7
        "chips",         // 8
        "lettuce",         // 9
        "hotdog",     // 10
        "table",      // 11
        "chair",          // 12
        "chair",         // 13
        "icecream",        // 14
        "sandwich" ,         // 15
        "hotdog" ,         // 16
        "cat"
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
