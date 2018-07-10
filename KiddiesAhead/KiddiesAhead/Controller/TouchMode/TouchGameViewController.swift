//
//  TouchGameViewController.swift
//  KiddiesAhead
//
//  Created by sts on 4/2/18.
//  Copyright © 2018 mingah. All rights reserved.
//

import UIKit

var g_touchGameRoot : TouchGameViewController?

class TouchGameViewController: UIViewController ,  UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var ui_collection: UICollectionView!
    var data = [TOUCH_GAME]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        g_touchGameRoot = self
        // Do any additional setup after loading the view.
        data = TOUCH_GAME.allValues
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gotoPlay(index : Int) {
        
        let vc = UIStoryboard(name:"TouchGame", bundle:nil).instantiateViewController(withIdentifier: data[index].rawValue) as! TouchPlayViewController
        vc.sceneName = R.string.SCENE_NAMES[index]
        vc.sceneIndex = index
        self.navigationController?.pushViewController(vc, animated: true)
        
        
    }
    

    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let index = indexPath.item
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GameCell", for: indexPath) as! GameCell
        
        cell.ui_image.layer.borderWidth = 6
        cell.ui_image.layer.borderColor = UIColor(red:169/255, green:118/255, blue:58/255, alpha: 1).cgColor
        cell.ui_image.layer.cornerRadius = 16
        cell.ui_image.image = UIImage(named:data[index].rawValue)
        cell.ui_lblName.text = R.string.SCENE_NAMES[index]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        gotoPlay(index : indexPath.item)
        
    }
}
