//
//  HelpViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/23/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

class HelpViewController: UIViewController {

    @IBOutlet weak var ui_lblWelcome: UILabel!
    @IBOutlet weak var ui_lblHelp: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ui_lblHelp.text = R.string.HOWTOPLAY
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
