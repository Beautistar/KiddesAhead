//
//  TouchPlayViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/4/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import AVFoundation
import SwiftyGif

class TouchPlayViewController: UIViewController {
    
    var words = [String]()
    var backWords = [String]()
    var ui_imvArrow : UIImageView!
    var ui_imvEnlarge : UIImageView!
    var enlargeRatio : CGFloat = 1
    
    var player : AVAudioPlayer?
    var sceneName = ""
    var sceneIndex = 0
    
    var currentTag = 0
    
    var isEnded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setTouches()
        
        var ratio :CGFloat = 1
        if DeviceType.IS_IPAD {
            ratio = 1.5
        }
        
        ui_imvEnlarge = UIImageView(frame:CGRect(x: 0, y: 0, width: Constants.MIN_IMAGE_SIZE * ratio, height: Constants.MIN_IMAGE_SIZE * ratio))
        ui_imvEnlarge.contentMode = .scaleAspectFit
        ui_imvEnlarge.isUserInteractionEnabled = true
        self.view.addSubview(ui_imvEnlarge)
        self.ui_imvEnlarge.isHidden = true
        
        let gif = UIImage(gifName: "arrow.gif")
        let gifmanager = SwiftyGifManager(memoryLimit:20)
        
        ui_imvArrow = UIImageView(frame: CGRect(x: 0, y: 0, width: 40.0 * ratio, height: 25.0 * ratio))
        self.ui_imvArrow.setGifImage(gif, manager: gifmanager)
        self.view.addSubview(ui_imvArrow)
        self.ui_imvArrow.isHidden = true
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let label = UILabel(frame: CGRect(x: 0, y: 20, width: 200, height: 40))
        label.textAlignment = .center
        label.text = sceneName
        label.textColor = UIColor(red: 169.0/255.0, green: 118.0/255.0, blue: 58.0/255.0, alpha: 1)
        
        var fontsize : CGFloat = 24
        if DeviceType.IS_IPAD {
            fontsize = 36
        }
        
        label.font = UIFont(name: "CarterOne", size: fontsize)
        label.sizeToFit()
        label.frame = CGRect(x: self.view.frame.width - label.bounds.width - 60, y: 0, width: label.bounds.width + 60, height: label.bounds.height)
        label.backgroundColor = UIColor.white.withAlphaComponent(0.25)
        self.view.addSubview(label)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isEnded {
            isEnded = false
            gotoNext()
            return
        }
        moveArrow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setTouches() {
        
        let imageViews = view.subviews.filter{$0 is UIImageView}
        
        for one in imageViews {
            
            if one.tag == 200 {     // 200 tag is touch disabled.
                continue
            }
            
            one.isUserInteractionEnabled = true
            let tapper = WordTapGesture(target: self, action: #selector(self.handleTap(_:)))
            tapper.index = one.tag
            one.addGestureRecognizer(tapper)
        }
    }
    
    func moveArrow() {
        
        ui_imvArrow.isHidden = false
        
        currentTag += 1
        
        if currentTag >= words.count {
            currentTag = 0
            ui_imvArrow.isHidden = true
            showWellDone()
        }
        
        if sceneName == R.string.BEDROOM && currentTag == 3 {       // rug
            
            if let image = self.view.viewWithTag(currentTag) {
                ui_imvArrow.center.x = image.frame.minX
                ui_imvArrow.center.y = image.center.y
                self.view.layoutIfNeeded()
            }
            
            return
        }
        
        if let image = self.view.viewWithTag(currentTag) as? UIImageView {
            ui_imvArrow.center.x = image.center.x - 20
            ui_imvArrow.center.y = image.center.y
            
            if image.bounds.width < Constants.MIN_IMAGE_SIZE || image.bounds.height < Constants.MIN_IMAGE_SIZE {
                
                var min = image.bounds.width
                if min > image.bounds.height {
                    min = image.bounds.height
                }
                
                var ratio = Constants.MIN_IMAGE_SIZE / min
                
                if ratio > 1.5 {
                    ratio = 1.5
                }
                
                enlargeRatio = ratio
                
                image.isHidden = true
                
                ui_imvEnlarge.image = image.image
                ui_imvEnlarge.frame = CGRect(x: 0, y : 0, width : image.bounds.width * ratio, height: image.bounds.height * ratio)
                ui_imvEnlarge.center = image.center
                ui_imvEnlarge.isHidden = false
                ui_imvEnlarge.tag = image.tag
                
                for recognizer in ui_imvEnlarge.gestureRecognizers ?? [] {
                    ui_imvEnlarge.removeGestureRecognizer(recognizer)
                }
                let tapper = WordTapGesture(target: self, action: #selector(self.handleTap(_:)))
                tapper.index = ui_imvEnlarge.tag
                ui_imvEnlarge.addGestureRecognizer(tapper)
                
                let original = ui_imvEnlarge.transform
                ui_imvEnlarge.transform = original.scaledBy(x: 1/ratio, y: 1/ratio)
                UIView.animate(withDuration: 0.2, animations: {
                    self.ui_imvEnlarge.transform = original
                }, completion: nil)
                
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleTap(_ sender:WordTapGesture) {
        
       let index = sender.index
        
        if index >= 300 {
            
            if index - 300 < backWords.count {
                playSound(word: backWords[index - 300])
            }
            
            return
        }
        
        if index >= words.count {
            return
        }
        
        var enlarged = false
        if ui_imvEnlarge.tag == index {
            enlarged = true
            
            ui_imvEnlarge.tag = 0
            ui_imvEnlarge.isHidden = true
            ui_imvEnlarge.image = nil
        }
        
        showWordAni(index, enlarged: enlarged)
        playSound(word: words[index])
        
        if index == currentTag {
            
            ui_imvArrow.isHidden = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                self.moveArrow()
            })
        }
        
    }
    
    func showWordAni(_ tag : Int, enlarged : Bool) {
        
        if tag == 0 {
            return
        }
        
        if let image = self.view.viewWithTag(tag) {
            
            image.isHidden = false
            
            if !enlarged {
            
                let original = image.transform
                UIView.animate(withDuration: 0.3, animations: {
                    image.transform = original.scaledBy(x: 1.25, y: 1.25)
                }, completion: {finished in
                    UIView.animate(withDuration: 0.3, animations: {() -> Void in
                        image.transform = original
                    })
                })
                
            } else {
                
                let original = image.transform
                image.transform = original.scaledBy(x: self.enlargeRatio, y: self.enlargeRatio)
                UIView.animate(withDuration: 0.3, animations: {
                    image.transform = original.scaledBy(x: 1.1 * self.enlargeRatio, y: 1.1 * self.enlargeRatio)
                }, completion: {finished in
                    UIView.animate(withDuration: 0.3, animations: {() -> Void in
                        image.transform = original
                    })
                })
            }
        }
    }

    func playSound(word : String) {
        
        if let player = self.player, player.isPlaying {
            player.stop()
        }
        
        guard let url = Bundle.main.url(forResource: word, withExtension: "mp3") else { return }
        
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.setVolume(1, fadeDuration: 0)
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func showWellDone() {
        
        isEnded = true
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "WellDoneViewController")
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    
    func gotoNext() {
        
        let data = TOUCH_GAME.allValues
        
        var index = sceneIndex + 1
        if index >= data.count {
            index = 0
        }
        
        let vc = UIStoryboard(name:"TouchGame", bundle:nil).instantiateViewController(withIdentifier: data[index].rawValue) as! TouchPlayViewController
        vc.sceneName = R.string.SCENE_NAMES[index]
        vc.sceneIndex = index
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func back() {
        
        if let root = g_touchGameRoot {
            self.navigationController?.popToViewController(root, animated: true)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

}


class WordTapGesture: UITapGestureRecognizer {
    var index = 0
}
