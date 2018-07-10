//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class BathroomPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "bathroom",        // 0
        "window",         // 1
        "mirror",         // 2
        "bathtub",         // 3
        "sink",          // 4
        "toothpaste",         // 5
        "toothbrush",         // 6
        "shampoo",     // 7
        "towel",      // 8
        "soap",         // 9
        "duck",            // 10
        "triangle",      // 11
        "triangle",      // 12
        "toilet",         // 13
        "toilettissue",        // 14
        "bin"        // 15

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
