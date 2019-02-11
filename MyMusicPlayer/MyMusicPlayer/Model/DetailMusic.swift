//
//  DetailMusic.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/2/8.
//  Copyright © 2019 王春杉. All rights reserved.
//


import Foundation
import Alamofire
import SwiftyJSON
struct DetailMusicId {
    static var id = 0
}

struct DetailMusic {
    var detailMusicInfo: [DetailMusicInfo]
    
    init() {
        self.detailMusicInfo = [DetailMusicInfo]()
    }
}
struct DetailMusicInfo {
    var name: String
    var id: Int
    var picUrl: String
    var singerName: String
    
    init() {
        self.name = ""
        self.id = 0
        self.picUrl = ""
        self.singerName = ""
    }
}

