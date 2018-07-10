//
//  AudioGameViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/2/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyUserDefaults

class AudioGameViewController: UIViewController {
    
    let INTERVAL = [6.0, 4.0, 2.0]

    @IBOutlet weak var ui_imvWord: UIImageView!
    @IBOutlet weak var ui_lblWord: UILabel!
    @IBOutlet weak var ui_card: UIView!
    @IBOutlet weak var ui_btnSpeed: UIButton!
    @IBOutlet weak var ui_btnPlay: UIButton!
    
    var player : AVAudioPlayer?
    var timer : Timer?
    var data = [WORDS]()
    var allWords = [WORDS]()
    var _current = 0
    var _speed = 1
    
    var finalCardPos :CGFloat = 0
    
    var isRestarting = false
    var isEnded = false
    var isPaused = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if Defaults[.cards] == nil {
            
            if g_user._age == 0 {
                Defaults[.cards] = 1
            } else {
                Defaults[.cards] = 2
            }
        }
        
        if Defaults[.speed] == nil {
            Defaults[.speed] = 1
        }
        
        _speed = Defaults[.speed]!
        
        loadWords()
        
        ui_card.alpha = 0
        
        ui_btnSpeed.setTitle("\(_speed + 1)x", for: .normal)
        
        ui_btnPlay.isSelected = !isPaused
        
//        timer = Timer.scheduledTimer(timeInterval: TimeInterval(INTERVAL), target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        finalCardPos = ui_card.layer.position.x
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isRestarting {
            showContinueAlert()
            isRestarting = false
            return
        }
        
        showCard()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        isEnded = true
        
        cancelTimer()
        
        if player != nil {
            player?.stop()
        }
    }
    
    func loadWords() {
        
        if Defaults[.categories] == nil {
            allWords = WORDS.allValues
        } else {
        
            let selected_categories = Defaults[.categories]!
            
            for category in WORD_CATEGORIES.allValues {
                
                if selected_categories[category.rawValue] {
                    allWords.append(contentsOf:categoryValues(category: category.rawValue))
                }
            }
        }
        
        makeData()
    }
    
    func makeData() {
        
        data.removeAll()
        
        let shuffled = makeRandomArray(allWords)
        
        var count = Constants.CARD_NUMBERS[Defaults[.cards]!]
        
        if count == 0 {
            count = allWords.count
        }
        
        if count > allWords.count {
            count = allWords.count
        }
        
        for i in 0..<count {
            data.append(shuffled[i])
        }
    }
    
    func next() {
        
        cancelTimer()

        timer = Timer.scheduledTimer(timeInterval: TimeInterval(INTERVAL[_speed]), target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: false)
    }
    
    @objc func onTimer() {
        
        _current = _current + 1
        if (_current >= data.count) {
            _current = 0
            cancelTimer()
            end()
            return
        }
        
        showCard()
    }
    
    func cancelTimer() {
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }

    func showCard() {
        
        var word = data[_current].rawValue;
        ui_imvWord.image = UIImage(named:word)
        
        word = word.replacingOccurrences(of: "_", with: " ").trimmed.uppercased()
        ui_lblWord.text = word
        
        ui_card.layer.position.x = self.view.frame.width
        ui_card.alpha = 1
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [.allowUserInteraction], animations: {
            
            self.ui_card.layer.position.x = self.finalCardPos
        }, completion: {finished in
            
                if self.isEnded || self.isPaused {
                    self.cancelTimer()
                    return
                }
            
                self.playSound()
                self.next()
            })
    }
    
    func playSound() {
        
        let sound = data[_current].rawValue.replacingOccurrences(of: "_", with: "")
        
        guard let url = Bundle.main.url(forResource: sound, withExtension: "mp3") else { return }
        
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.setVolume(1, fadeDuration: 0)
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func showContinueAlert() {
        
        let alert = UIAlertController(title: "", message: R.string.CONTINUE_Q, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.CONTINUE, style: .default, handler: { action in
            self.makeData()
            self.isEnded = false
            self.isPaused = false
            self.showCard()
        }))
            
        alert.addAction(UIAlertAction(title: R.string.LATER, style: .default, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }))
        
        DispatchQueue.main.async(execute:  {
            self.present(alert, animated: true, completion: nil)
        })
    }
    
    func end() {
        
        isRestarting = true
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "WellDoneViewController") as! WellDoneViewController
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onPlay(_ sender: Any) {
        
        isPaused = !isPaused
        ui_btnPlay.isSelected = !isPaused
        
        if !isPaused {
            self.playSound()
            self.next()
        }
    }
    
    @IBAction func onPrev(_ sender: Any) {
        
        _current = _current - 1
        if (_current < 0) {
            _current = 0
        }
        
        showCard()
    }
    
    @IBAction func onSpeed(_ sender: Any) {
        
        _speed += 1
        if _speed > 2 {
            _speed = 0
        }
        
        Defaults[.speed] = _speed
        
        ui_btnSpeed.setTitle("\(_speed + 1)x", for: .normal)
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }


}
