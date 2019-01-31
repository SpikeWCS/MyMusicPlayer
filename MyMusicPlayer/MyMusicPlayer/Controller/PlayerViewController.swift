//
//  PlayerViewController.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/1/31.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

class PlayerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
