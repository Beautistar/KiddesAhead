//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class AirportPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "airport",        // 0
        "station",         // 1
        "airplane",         // 2
        "sun",         // 3
        "airplane",         // 4
        "car",        // 5
        "girl",        // 6
        "girl",          // 7
        "trunk",         // 8
        "dog",         // 9
        "policeofficer",     // 10
        "daddy",      // 11
        "mummy",          // 12
        "boy",         // 13
        "bus",        // 14
        "trunk"          // 15
        
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
