//
//  ClassroomPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class PetShopPlayViewController: TouchPlayViewController {
    
    let WORDS = [
        "petshop",        // 0
        "mouse",         // 1
        "dog",         // 2
        "cat",         // 3
        "rabbit",         // 4
        "turtle",        // 5
        "snake",        // 6
        "alligator"          // 7
        
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
