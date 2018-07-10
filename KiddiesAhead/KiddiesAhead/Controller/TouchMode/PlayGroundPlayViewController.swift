//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class PlayGroundPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "sky",        // 0
        "grass",         // 1
        "tree",         // 2
        "swing",         // 3
        "house",         // 4
        "slide",        // 5
        "tree",        // 6
        "door",          // 7
        "boy",         // 8
        "boy",         // 9
        "ball",     // 10
        "boy",      // 11
        "girl",          // 12
        "girl"         // 13
        
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
