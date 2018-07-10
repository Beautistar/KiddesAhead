//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class SupermarketPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "supermarket",        // 0
        "orangejuice",         // 1
        "water",         // 2
        "orangejuice",         // 3
        "orangejuice",         // 4
        "orangejuice",        // 5
        "cheese",        // 6
        "cookie",         // 7
        "corn",        // 8
        "milk" ,         // 9
        "sweets",     // 10
        "hotdog",      // 11
        "cookie",          // 12
        "orangejuice",          // 13
        "cheese",         // 14
        "cookie",         // 15
        "melon" ,         // 16
        "broccoli" ,         // 17
        "carrot",      // 18
        "tomato",     // 19
        "potatoes",     // 20
        "cookie",      // 21
        "hotdog",          // 22
        "sweets",         // 23
        "orangejuice",        // 24
        "bread" ,         // 25
        "yogurt" ,         // 26
        "ham" ,         // 27
        "fish",      // 28
        "ham"      // 29
        
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
