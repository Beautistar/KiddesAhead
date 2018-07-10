//
//  MusicGameViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/2/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import AVFoundation

class MusicGameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate {
    
    let INTERVAL = 1

    @IBOutlet weak var ui_imvPlayBack: UIImageView!
    @IBOutlet weak var ui_tableView: UITableView!
    @IBOutlet weak var ui_lblDuration: UILabel!
    @IBOutlet weak var ui_lblName: UILabel!
    @IBOutlet weak var ui_slider: UISlider!
    @IBOutlet weak var ui_btnPlay: UIButton!
    
    var musics = [MusicModel]()
    var selectedMusic : MusicModel!
    var selectedIndex = -1
    
    var player : AVAudioPlayer?
    var timer : Timer?
    
    let MUSIC_NAMES = [R.music.MUSIC_0, R.music.MUSIC_1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ui_tableView.rowHeight = UITableViewAutomaticDimension
        ui_tableView.estimatedRowHeight = 52

        ui_imvPlayBack.layer.borderWidth = 4
        ui_imvPlayBack.layer.borderColor = UIColor(red:254/255, green:178/255, blue:32/255, alpha: 1).cgColor
        ui_imvPlayBack.layer.cornerRadius = 16
        
        ui_slider.isEnabled = false
        
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(INTERVAL), target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
        
        loadMusics()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        selectMusic(index: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
        
        if player != nil {
            player?.stop()
        }
    }
    
    func loadMusics() {
        
        for i in 0..<MUSIC_NAMES.count {
            let one = MusicModel(name:MUSIC_NAMES[i], path:"music_\(i)")
            if i == 0 {
                one._selected = true
            }
            
            musics.append(one)
        }
    }
    
    func selectMusic(index : Int) {
        
        if selectedIndex == index {
            return
        }
        
        selectedIndex = index
        
        if selectedMusic != nil {
            selectedMusic._selected = false
        }
        
        selectedMusic = musics[index]
        selectedMusic._selected = true
        
        ui_tableView.reloadData()
        
        guard let url = Bundle.main.url(forResource:selectedMusic._path, withExtension: "mp3") else { return }
        
        do {
            
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            player.setVolume(1, fadeDuration: 0)
            player.prepareToPlay()
            player.play()
            player.delegate = self
            
            updatePlayInfo()
            
            ui_btnPlay.isSelected = true
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updatePlayInfo() {
        
        ui_lblName.text = selectedMusic._name
        let duration = Int(player!.duration)
        let min = Int(duration / 60)
        let sec = duration - min * 60
        ui_lblDuration.text = String(format:"%02d:%02d", min, sec)
        
        ui_slider.maximumValue = Float(duration)
        
    }
    
    @objc func onTimer() {
        
        guard player != nil else { return }
        
        ui_slider.value = Float(player!.currentTime)
    }
    
    @IBAction func onPlay(_ sender: UIButton) {
        
        guard player != nil else { return }

        if player!.isPlaying {
            sender.isSelected = false
            player?.pause()
        } else {
            sender.isSelected = true
            player?.play()
        }
    }
    
    @IBAction func onPrev(_ sender: Any) {
        
        var index = selectedIndex - 1
        if index < 0 {
            index = 0
        }
        
        selectMusic(index: index)
    }
    
    func next() {
        var index = selectedIndex + 1
        if index >= musics.count {
            index = musics.count - 1
        }
        
        selectMusic(index: index)
    }
    
    @IBAction func onNext(_ sender: Any) {
        
        next()
    }
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath) as! MusicCell
        cell.selectionStyle = .none
        
        let one = musics[indexPath.row]
        cell.ui_check.isHidden = !one._selected
        
        cell.ui_lblName.text = one._name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectMusic(index:indexPath.row)
        ui_tableView.reloadData()
    }
    
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        ui_btnPlay.isSelected = false
        
        if flag {
            next()
        }
    }

}
