//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class StreetPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "street",        // 0
        "road",         // 1
        "sun",         // 2
        "house",         // 3
        "house",         // 4
        "house",        // 5
        "house",        // 6
        "house",          // 7
        "car",         // 8
        "taxi",         // 9
        "motorcycle",     // 10
        "bicycle",      // 11
        "helicopter",          // 12
        "dog",         // 13
        "cat",        // 14
        "cloud" ,         // 15
        "cloud"          // 16
        
        
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
