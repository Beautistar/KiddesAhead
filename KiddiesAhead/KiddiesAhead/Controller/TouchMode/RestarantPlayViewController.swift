//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class RestaurantPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "restaurant",        // 0
        "table",         // 1
        "man",         // 2
        "woman",         // 3
        "fish",         // 4
        "corn",        // 5
        "bread",        // 6
        "table",          // 7
        "girl",         // 8
        "cake",         // 9
        "coffee",     // 10
        "waiter",      // 11
        "chicken",         // 12
        "table",         // 13
        "plate"         // 14
   
    ]
    
    let BACK_WORDS = [
        "window",      // 300
        "plant",
        "floor"
        
        
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
