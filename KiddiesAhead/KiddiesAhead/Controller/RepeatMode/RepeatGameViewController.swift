//
//  RepeatGameViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/2/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import AVFoundation
import Speech
import SwiftyUserDefaults

class RepeatGameViewController: BaseViewController,  UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var ui_collection: UICollectionView!
    @IBOutlet weak var ui_lblWord: UILabel!
    @IBOutlet weak var ui_mask: UIView!
    @IBOutlet weak var ui_imvScore: UIImageView!
    @IBOutlet weak var ui_btnPrev: UIButton!
    @IBOutlet weak var ui_btnNext: UIButton!
    @IBOutlet weak var ui_lblBestWord: UILabel!
    
    //let INTERVAL = 2
    let RECORDING_INTERVAL = 2.5
    let SCORE_INTERVVAL = 1.0
    let READY_INTERVAL = 1.4

    var data = [WORDS]()
    var allWords = [WORDS]()
    
    var _current = 0
    var player : AVAudioPlayer?
    
    let audioEngine = AVAudioEngine()
    var speechRecognizer: SFSpeechRecognizer?
    var request : SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    var isRecording = false
    var bestString = ""
    var isAlreadyRecognized = false
    
    var isRestarting = false
    var isEnded = false
    
    var alreadyStarted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWords()
        
        var word = data[0].rawValue;
        word = word.replacingOccurrences(of: "_", with: " ").trimmed.uppercased()
        ui_lblWord.text = word
        ui_mask.isHidden = true
        
        self.requestRecordingPermission()     // for simulator
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if isRestarting {
            showContinueAlert()
            isRestarting = false
            return
        }
        
        selectWord(index:0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if player != nil {
            player?.stop()
        }
        
        cancelRecording()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        ui_collection.reloadData()
    }
    
    func selectWord(index : Int) {
        
        if isEnded {
            return
        }
        
        _current = index
        
        if _current < 0 {
            _current = 0
        }
        
        if _current >= data.count {
            _current = data.count - 1
        }
        
        var word = data[_current].rawValue;
        word = word.replacingOccurrences(of: "_", with: " ").trimmed.uppercased()
        ui_lblWord.text = word
        
        playSound(index: index)
    }
    
    func playSound(index : Int) {
        
        if player != nil && player!.isPlaying && isRecording{
            return
        }
        
        disableButtons(true)
        
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + READY_INTERVAL, execute: {
            self.onMic()
        })
    }
    
    func onMic() {
        
        if player != nil && player!.isPlaying {
            player!.stop()
        }
        
        ui_mask.isHidden = false
        ui_imvScore.image = UIImage(named:"recording")
        
        if isRecording {
            return
        }
        
        isRecording = true
        isAlreadyRecognized = false
        self.recordAndRecognizeSpeech()   // for simulator
        
        DispatchQueue.main.asyncAfter(deadline: .now() + RECORDING_INTERVAL, execute: {
            self.cancelRecording()
            self.showScore(score:self.calcScore())
            
        })
    }
    
    func recordAndRecognizeSpeech() {
        
        let node = audioEngine.inputNode
        self.request = SFSpeechAudioBufferRecognitionRequest()
        
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request!.append(buffer)
        }
        
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            // here has been an audio engine error.
            return print(error)
        }
        
        let locale = NSLocale(localeIdentifier: "en_GB")
        
        guard let myRecognizer = SFSpeechRecognizer(locale: locale as Locale) else {
            // Speech recognition is not supported for your current locale.
            
            return
        }
        if !myRecognizer.isAvailable {
            //Speech recognition is not currently available. Check back at a later time.
            
            self.showAlertDialog(title: R.string.ERROR, message: R.string.SPEECH_NOTAVAILABLE, positive: R.string.OK, negative: nil)
            return
        }
        
        speechRecognizer = myRecognizer
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request!, resultHandler: { result, error in
            
            if let result = result {
                self.bestString = result.bestTranscription.formattedString.lowercased()
            } else if error != nil {
                print(error!.localizedDescription)
                self.bestString = ""
            }
            
            // for debug
            //self.ui_lblBestWord.text = self.bestString      // print best string
            
            if self.calcScore() == .PERFECT {
                self.showScore(score: .PERFECT)
                self.cancelRecording()
            }
        })
    }
    
    
    func calcScore() -> SCORE{
    
        var score : SCORE = .PERFECT
        var word = data[_current].rawValue;
        word = word.replacingOccurrences(of: "_", with: " ").trimmed.lowercased()
        
        print("you said \(bestString)");
        
        var numberWord = ""
        
        let index = indexOfWord(word: data[_current])
        if index >= indexOfWord(word: .one) && index <= indexOfWord(word: .one_hundred) {
            numberWord = NUMBER_STRING[index - indexOfWord(word: .one)]
        }
        
        if bestString.isEmpty {
            score = .BAD
        } else if bestString == word || bestString == numberWord{
            score = .PERFECT
        } else {
            let dist = Utils.levenshtein(aStr:bestString, bStr:word)
            
            let THRESOLD = 3
            
            if dist >= word.count {
                score = .BAD
            } else if dist < THRESOLD {
                
                if word.first == bestString.first {
                    score = .GOOD
                } else {
                    score = .BAD
                }
            } else {
                score = .BAD
            }
            
        }
        
        return score
    
    }
    
    func showScore(score : SCORE) {
        
        alreadyStarted = false
        
        if self.isAlreadyRecognized {
            return
        }
        
        ui_imvScore.image = UIImage(named:score.rawValue)
        self.isAlreadyRecognized = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + SCORE_INTERVVAL, execute: {
            self.ui_mask.isHidden = true
            self.disableButtons(false)
        })
    }
    
    func cancelRecording() {
        
        if isRecording {
            
            isRecording = false

            audioEngine.stop()
            
            let node = audioEngine.inputNode
            node.removeTap(onBus: 0)
            request?.endAudio()
            request = nil
            recognitionTask?.cancel()
            recognitionTask = nil
        }
    }
    
    func requestRecordingPermission() {
        
        let session = AVAudioSession.sharedInstance()
        if (session.responds(to: #selector(AVAudioSession.requestRecordPermission(_:)))) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                
                if granted {
                    
                    do {
                        try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:[.defaultToSpeaker])
                        try session.setActive(true)
                        self.requestSpeechAuthorization()
                    }
                    catch {
                        print("Couldn't set Audio session category")
                    }
                } else{
                    print("not granted")
                }
            })
        }
        
    }
    
    func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    break
                case .denied:
                    break
                case .restricted:
                    break
                case .notDetermined:
                    break
                }
            }
        }
    }
    
    func disableButtons(_ yesno : Bool) {
        
        ui_btnPrev.isEnabled = !yesno
        ui_btnNext.isEnabled = !yesno
    }
    
    func showContinueAlert() {
        
        let alert = UIAlertController(title: "", message: R.string.CONTINUE_Q, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.CONTINUE, style: .default, handler: { action in
            
            self.makeData()
            self.ui_collection.scrollToItem(at: IndexPath(item:0, section:0), at: .centeredHorizontally, animated: false)
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
        alreadyStarted = false
        
        let vc = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "WellDoneViewController") as! WellDoneViewController
        self.navigationController?.present(vc, animated: true, completion: nil)
    }
    

    @IBAction func onBack(_ sender: Any) {
        isEnded = true
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onPrev(_ sender: Any) {
        
        let index = _current - 1
        if (index < 0) {
            return
        }
        
        ui_collection.scrollToItem(at: IndexPath(item:index, section:0), at: .centeredHorizontally, animated: true)
        
    }
    
    
    @IBAction func onNext(_ sender: Any) {
        
        let index = _current + 1
        if (index >= data.count) {
            end()
            return
        }
        
        ui_collection.scrollToItem(at: IndexPath(item:index, section:0), at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.item
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        
        cell.ui_image.image = UIImage(named:data[index].rawValue)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let index = indexPath.item

        if alreadyStarted {
            return
        }
        
        playSound(index: index)
        alreadyStarted = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let w = ScreenSize.SCREEN_WIDTH * 0.45;
        let size = CGSize(width: w, height: w * 0.6)
        
        return size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        
        if isRestarting || isEnded {
            return
        }
        
        if let ip = ui_collection.indexPathForItem(at: center) {
            selectWord(index: ip.item)
        }
    }
}
