//
//  DetailMusicController.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/2/8.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit
import Alamofire
class DetailMusicController: UIViewController {
    
    var detailMusic: DetailMusic!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("get前")

        DetailMusicHelper.getMusicList(success: { musicList in
            print("get1")
            self.detailMusic = musicList
            print("get2")
            print("DetailMusic成功：\(self.detailMusic.playlist.id)")
        }) { _ in
            print("00")
        }

    }
}
