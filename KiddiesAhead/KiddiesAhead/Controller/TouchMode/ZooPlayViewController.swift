//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class ZooPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "zoo",        // 0
        "sun",         // 1
        "elephant",         // 2
        "giraffe",         // 3
        "alligator",         // 4
        "lion",        // 5
        "monkey",        // 6
        "squirrel",          // 7
        "turtle",         // 8
        "snake",         // 9
        "fox",     // 10
        "rabbit",      // 11
        "bird",          // 12
        "bear",         // 13
        "horse",        // 14
        "pig" ,         // 15
        "hippo" ,         // 16
        "tree" ,         // 17
        "tree"      // 18
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
