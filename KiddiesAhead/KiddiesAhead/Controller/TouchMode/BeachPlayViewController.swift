//
//  BeachPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class BeachPlayViewController: TouchPlayViewController {
    
    
    let WORDS = [
        "beach",        // 0
        "tree",         // 1
        "ball",         // 2
        "bird",         // 3
        "boat",         // 4
        "chair",        // 5
        "umbrella",        // 6
        "dog",          // 7
        "dolphin",         // 8
        "girl",         // 9
        "icecream",     // 10
        "slipper",      // 11
        "sun",          // 12
        "tree",         // 13
        "cloud",        // 14
        "cloud",        // 15
        "dolphin",          // 16
        "cloud"
    ]
    
    let BACK_WORDS = [
        "sky",      // 300
        "sea",
        "sand"
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
