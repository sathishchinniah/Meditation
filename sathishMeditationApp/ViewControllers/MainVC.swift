//
//  ViewController.swift
//  sathishMeditationApp
//
//  Created by SATHISH on 5/4/19.
//  Copyright © 2019 sathish. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet var outerView: UIView! {
        didSet {
            outerView.layer.cornerRadius = 5
           outerView.layer.backgroundColor = UIColor.lightGray.cgColor
        }
    }
    
}
class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, GIDSignInUIDelegate {
    
   
    @IBOutlet var logOutBtn: UIBarButtonItem!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    let reuseIdentifier = "MyCollectionViewCell"
    var collectionNames = [String]()
    var imageUrl:String?
    var musicUrl:String?
    let nc = NotificationCenter.default
    var userLogIn = Bool()
    var catName:String?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().uiDelegate = self
        collectionNames = UserDefaults.standard.object(forKey: "collectionNames") as! [String]
        nc.addObserver(self, selector: #selector(userLoggedIn), name: Notification.Name("UserLoggedIn"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        if userLogIn == false  {
            collectionView.isHidden = true
            signInButton.isHidden = false
            self.logOutBtn.isEnabled = false
            self.logOutBtn.tintColor = UIColor.clear
            
        }else {
            collectionView.isHidden = false
            signInButton.isHidden = true
            self.logOutBtn.isEnabled = true
            self.logOutBtn.tintColor = UIColor.white
            
        }
    }
    
    @objc func userLoggedIn() {
        userLogIn = true
        collectionView.isHidden = false
        signInButton.isHidden = true
        self.logOutBtn.isEnabled = true
        self.logOutBtn.tintColor = UIColor.white
        
    }
 
    @IBAction func googleSignIn(sender: AnyObject) {
        GIDSignIn.sharedInstance().signIn()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! MyCollectionViewCell
        cell.myLabel.text = self.collectionNames[indexPath.item]
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MyCollectionViewCell
        catName = cell.myLabel.text
        self.performSegue(withIdentifier: "showdetail", sender: self)
    }

    
    @IBAction func logoutTap(_ sender: Any) {
        userLogIn = false
        collectionView.isHidden = true
        signInButton.isHidden = false
        self.logOutBtn.isEnabled = false
        self.logOutBtn.tintColor = UIColor.clear
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showdetail") {
            let vc = segue.destination as! MeditationVC
            vc.titleLabel = catName
        }
    }
}

