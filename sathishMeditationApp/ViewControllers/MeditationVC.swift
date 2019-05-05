//
//  MeditationViewController.swift
//  sathishMeditationApp
//
//  Created by SATHISH on 5/4/19.
//  Copyright © 2019 sathish. All rights reserved.
//

import UIKit
import AVFoundation
import Firebase

class MeditationVC: UIViewController,AVAudioPlayerDelegate {

    @IBOutlet var mainView: UIView!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var playBtn: UIButton! {
        didSet {
            playBtn.layer.cornerRadius = 5
        }
    }
    var player:AVPlayer?
    var playerItem:AVPlayerItem?
    var imageUrl:String?
    var muscUrl:String?
    var titleLabel:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func viewWillAppear(_ animated: Bool) {
        self.title = titleLabel
        mainView.isHidden = true
        fetchSubCollection(Name: titleLabel!)
    }
    
  
    func fetchSubCollection(Name:String) {
        
    activityIndicator.startAnimating()
    let db = Firestore.firestore()
    db.collection("user").document(Name).collection("session").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    let docData = document.data()
                    self.imageUrl = docData["imageLink"] as? String ?? ""
                    self.muscUrl = docData["link"] as? String ?? ""
                    let url = URL(string: self.imageUrl!)
                    let data = try? Data(contentsOf: url!)
                    
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        self.imageView.image = image
                    }
                }
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.mainView.isHidden = false
            }
        }
        
    }

    @IBAction func playBtnTap(_ sender: Any) {
        let url = URL(string: muscUrl!)
        let playerItem:AVPlayerItem = AVPlayerItem(url: url!)
        self.player = AVPlayer(playerItem: playerItem)
        self.player!.play()
        playBtn.setTitle("STOP", for: .normal)
    }
   
}
