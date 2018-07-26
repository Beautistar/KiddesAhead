//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class SupermarketPlayViewController: TouchPlayViewController {
    
    
    // remove first orangejuice and change index.
    let WORDS = [
        "supermarket",              // 0
        //"orangejuice",            // 1
        "water",                    // 1
        "orangejuice",              // 2
        "orangejuice",              // 3
        "orangejuice",              // 4
        "cheese",                   // 5
        "cookie",                   // 6
        "corn",                     // 7
        "milk" ,                    // 8
        "sweets",                   // 9
        "hotdog",                   // 10
        "cookie",                   // 11
        "orangejuice",              // 12
        "cheese",                   // 13
        "cookie",                   // 14
        "melon" ,                   // 15
        "broccoli" ,                // 16
        "carrot",                   // 17
        "tomato",                   // 18
        "potatoes",                 // 29
        "cookie",                   // 20
        "hotdog",                   // 21
        "sweets",                   // 22
        "orangejuice",              // 23
        "bread" ,                   // 24
        "yogurt" ,                  // 25
        "ham" ,                     // 26
        "fish",                     // 27
        "ham"                       // 28
        
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
