//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class KitchenPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "kitchen",        // 0
        "window",         // 1
        "chef",         // 2
        "pear",         // 3
        "lemon",         // 4
        "orangejuice",        // 5
        "pancake",        // 6
        "cooker",          // 7
        "cabinet",         // 8
        "banana",        // 9
        "sink",            // 10
        "fridge",           //11
        "apron",
        "gloves"
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
