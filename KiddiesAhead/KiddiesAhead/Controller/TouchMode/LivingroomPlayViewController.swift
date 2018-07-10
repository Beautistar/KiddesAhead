//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class LivingroomPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "livingroom",        // 0
        "window",         // 1
        "bookshelf",         // 2
        "lamp",         // 3
        "photograph",         // 4
        "photograph",        // 5
        "clock",        // 6
        "table",          // 7
        "tv",         // 8
        "flower",         // 9
        "sofa",     // 10
        "sofa",      // 11
        "table",          // 12
        "book",         // 13
        "cup",        // 14
        "monkey" ,         // 15
        "bottle" ,         // 16
        "chair"
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
