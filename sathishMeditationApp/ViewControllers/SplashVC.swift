//
//  SplashVC.swift
//  sathishMeditationApp
//
//  Created by SATHISH on 5/4/19.
//  Copyright © 2019 sathish. All rights reserved.
//

import UIKit
import Lottie

class SplashVC: UIViewController {

   var loadingView = AnimationView(name: "loading")
    
    override func viewDidLoad() {
        super.viewDidLoad()
         playAnimation()
    }

    func playAnimation(){
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 340, height: 340)
        //loadingView.loopAnimation = true
        loadingView.loopMode = .loop
        loadingView.contentMode = .scaleAspectFill
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.clear
        view.addSubview(loadingView)
        loadingView.play()
        delayWithSeconds(4) {
              self.performSegue(withIdentifier: "showhome", sender: self)
        }
      
    }
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }

}
