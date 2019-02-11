//
//  DetailMusicController.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/2/8.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class DetailMusicController: UIViewController {
    
    var detailMusic: DetailMusic!
    var musicListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        // 使用Alamofire 加载 DetailMusic
        var MusicListUrl = "http://localhost:3000/playlist/detail?id=\(DetailMusicId.id)"
        Alamofire.request(MusicListUrl).responseJSON { response in
                switch response.result.isSuccess {
                case true:
                    //把得到的JSON数据转为数组
                    if let value = response.result.value {
                        let json = JSON(value)
                        self.detailMusic = DetailMusic()
                        for i in 0...json["playlist"]["tracks"].count-1  {
                            var detailMusicDemo = DetailMusicInfo()
                            detailMusicDemo.name = json["playlist"]["tracks"][i]["name"].string!
                            detailMusicDemo.id = json["playlist"]["tracks"][i]["id"].int!
                            detailMusicDemo.picUrl = json["playlist"]["tracks"][i]["al"]["picUrl"].string!
                            detailMusicDemo.singerName = json["playlist"]["tracks"][i]["ar"][0]["name"].string!
                            self.detailMusic.detailMusicInfo.append(detailMusicDemo)
                        }
                        print("DetailMusic成功：\(self.detailMusic.detailMusicInfo[0].name)")
                        
                        self.setTableView()
                    }else {
                        print("else")
                    }
                case false:
                    print(response.result.error)
                }
        }
    }
    
    func setTableView(){
        musicListTableView = UITableView(frame: CGRect(x: 0, y: 0, width: Device.width, height: Device.height), style: .plain)
        musicListTableView.separatorStyle = .singleLine
        musicListTableView.backgroundColor = .clear
        musicListTableView.delegate = self
        musicListTableView.dataSource = self
        self.view.addSubview(musicListTableView)
        
    }
}

extension DetailMusicController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailMusic.detailMusicInfo.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if detailMusic == nil {
            return UITableViewCell()
        }else {
            return DetailMuiscListTableViewCell(detailMusic: detailMusic, index: indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO:
    }
}
