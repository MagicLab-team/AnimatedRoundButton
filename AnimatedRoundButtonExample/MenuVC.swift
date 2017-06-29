//
//  MenuVC.swift
//  AnimatedRoundButton
//
//  Created by Roman Sorochak on 6/28/17.
//  Copyright © 2017 MagicLab. All rights reserved.
//

import UIKit
import AnimatedRoundButton

class MenuVC: UIViewController {
    
    @IBOutlet weak var menuButton: AnimatedRoundButton!
    @IBOutlet weak var streamButton: AnimatedRoundButton!
    @IBOutlet weak var demoButton: AnimatedRoundButton!
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuButton.font = UIFont(name: "Helvetica", size: 20)!
        demoButton.font = UIFont(name: "Helvetica", size: 20)!
        streamButton.font = UIFont(name: "Helvetica", size: 25)!
    }
}
