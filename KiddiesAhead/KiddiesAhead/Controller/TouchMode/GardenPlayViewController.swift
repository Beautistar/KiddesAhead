//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class GardenPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "garden",        // 0
        "tree",         // 1
        "tree",         // 2
        "flower",         // 3
        "girl",         // 4
        "dog",        // 5
        "icecream",        // 6
        "bench",          // 7
        "sun",         // 8
        "cloud",         // 9
        "mummy",     // 10
        "grass",      // 11
        "flower",          // 12
        "children",         // 13
        "boy",        // 14
        "ball",         // 15
        "boy",       // 16
        "apple"
    ]
    
    let BACK_WORDS = [
        "fence"     // 300
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
