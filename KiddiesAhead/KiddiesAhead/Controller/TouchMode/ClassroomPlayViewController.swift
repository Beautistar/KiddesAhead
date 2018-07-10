//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class ClassroomPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "classroom",        // 0
        "blackboard",         // 1
        "teacher",         // 2
        "clock",         // 3
        "window",         // 4
        "bookshelf",        // 5
        "book",        // 6
        "bag",          // 7
        "tv",         // 8
        "hat",         // 9
        "ruler",     // 10
        "star",      // 11
        "pupil",          // 12
        "flower",         // 13
        "globe",        // 14
        "desk" ,         // 15
        "pupil" ,         // 16
        "chair" ,         // 17
        "star"      // 18
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
