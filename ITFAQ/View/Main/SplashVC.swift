//
//  SplashVC.swift
//  ITFAQ
//
//  Created by Keyur on 13/12/21.
//

import UIKit
import Lottie

class SplashVC: UIViewController {

    @IBOutlet weak var splashView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setSplashAnimation()
    }

    func setSplashAnimation()
    {
        let animationView = AnimationView(name: "lipstick")
        animationView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        splashView.addSubview(animationView)
        animationView.play()
        
        delay(3.0) {
            let vc : HomeVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: MAIN_STORYBOARD.HomeVC.rawValue) as! HomeVC
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }

}

