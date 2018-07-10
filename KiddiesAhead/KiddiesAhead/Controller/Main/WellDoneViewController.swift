//
//  WellDoneViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/24/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import AVFoundation

class WellDoneViewController: UIViewController {
    
    var player : AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapper = UITapGestureRecognizer(target: self, action: #selector(self.handleTapView(_:)))
        self.view.addGestureRecognizer(tapper)
        
        playSound()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.dismiss(animated: true, completion: nil)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound() {
        
        guard let url = Bundle.main.url(forResource: "wow_welldone", withExtension: "mp3") else { return }
        
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.setVolume(1, fadeDuration: 0)
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }

    @objc func handleTapView(_ sender:UITapGestureRecognizer) {
        
        self.dismiss(animated: true, completion: nil)
    }

}
