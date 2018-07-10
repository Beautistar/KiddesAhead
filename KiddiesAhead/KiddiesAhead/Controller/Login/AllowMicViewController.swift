//
//  AllowMicViewController.swift
//  KiddiesAhead
//
//  Created by sts on 3/31/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

class AllowMicViewController: UIViewController {

    var fromLogin = false;

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func requestRecordingPermission() {
        
        let session = AVAudioSession.sharedInstance()
        if (session.responds(to: #selector(AVAudioSession.requestRecordPermission(_:)))) {
            AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool)-> Void in
                if granted {
                    
                    do {
                        try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
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
                
                self.gotoAllowNoti()
            }
        }
    }
    
    func gotoAllowNoti() {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllowNotiViewController") as! AllowNotiViewController
        vc.fromLogin = fromLogin
        self.navigationController?.pushViewController(vc, animated: true)
    }

    
    @IBAction func onAllow(_ sender: Any) {
        
        requestRecordingPermission()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
