//
//  ViewController.swift
//  KiddiesAhead
//
//  Created by sts on 3/3/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let MODE_TITLES = [R.string.MODE_1, R.string.MODE_2, R.string.MODE_3, R.string.MODE_4]

    @IBOutlet weak var ui_collection: UICollectionView!
    
    var fromSubscription = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if fromSubscription {
            gotoHelp()
            fromSubscription = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.hhell
    }
    
    func checkSubscription() -> Bool {
        
        if Defaults[.learning] == nil {
            Defaults[.learning] = "en"
        }
        
        var endDate : Date?
        if let lang = Defaults[.learning] {
        
            switch lang {
                
            case "en":
                endDate = g_user._enEnd
            case "es":
                endDate = g_user._esEnd
            case "fr":
                endDate = g_user._frEnd
            case "yb":
                endDate = g_user._ybEnd
            default:
                break
            }
        }
        
        if endDate == nil {
            return false
        }
        
        let current = Date()
        
        if endDate! < current{
            return false
        }
        
        return true
    }
    
    
    func gotoSubscription() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SubscriptionViewController") as! SubscriptionViewController
        vc.fromWhere = 0
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func gotoAudio() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AudioGameViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func gotoTouch() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TouchGameViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func gotoAfrerMe() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RepeatGameViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func gotoMusic() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MusicGameViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func gotoHelp() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpViewController")
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func onProfile(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func onSetting(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController")
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    @IBAction func onHelp(_ sender: Any) {
        gotoHelp()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return MODE_TITLES.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.item
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as! HomeCell
        
        cell.ui_imvIcon.image = UIImage(named:"home_ic_\(index + 1)")
        cell.ui_txvTitle.text = MODE_TITLES[index]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !checkSubscription() {
            gotoSubscription()
            return
        }
        
        let index = indexPath.item
        let mode = GAME_MODE(rawValue : index)!
        
        switch mode {
        case .AUDIO:
            gotoAudio()
        case .TOUCH:
            gotoTouch()
        case .AFTERME:
            gotoAfrerMe()
        case .MUSIC:
            gotoMusic()

        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenSize = UIScreen.main.bounds.size

        let w = (screenSize.width) * 0.21 - 10;
        let size = CGSize(width: w, height: w * 2 / 3)
        
        return size
    }
}

