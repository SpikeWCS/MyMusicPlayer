//
//  PlayerViewController.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/1/31.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer
import Alamofire
import SwiftyJSON

extension UIImageView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
struct PlayedSong {
    static var id: Int = 0
}
class PlayerViewController: UIViewController {
    var playBtn: UIButton!
    var playSlider: UISlider!
    var playTime: UILabel!      // 当前播放时间标签
    var coverImageView: UIImageView!
    var lastSongBtn: UIButton!
    var nextSongBtn: UIButton!
    var currentTimeLable: UILabel!
    var endTimeLable: UILabel!
    var musicUrl: String!
    
    // 播放器相关
    var playerItem: AVPlayerItem?
    var player: AVPlayer?
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setController()
        
        let currentMusicUrl = "http://localhost:3000/song/url?id=\(PlayedSong.id)"
        Alamofire.request(currentMusicUrl).responseJSON { response in
            switch response.result.isSuccess {
            case true:
                //把得到的JSON数据转为数组
                if let value = response.result.value {
                    let json = JSON(value)
                    self.musicUrl = json["data"][0]["url"].string!
                    print(self.musicUrl)
                    self.setPlayer()
                }
            case false:
                print(response.result.error)
            }
        }
    }
    // MARK: - 初始化页面
    func setController() {
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        coverImageView = UIImageView(image: UIImage(named: "test"))
        coverImageView.frame = CGRect(x: Device.width/4, y: Device.height/5, width: Device.width/2, height: Device.width/2)
        coverImageView.setRounded()
        self.view.addSubview(coverImageView)
        
        playBtn = UIButton(type: .system)
        playBtn.frame = CGRect(x: Device.width/2 - Device.width/10, y: Device.height*4/5 - Device.width/10, width: Device.width/5, height: Device.width/5)
        playBtn.setBackgroundImage(UIImage(named: "play"), for: .normal)
        self.view.addSubview(playBtn)
        
        lastSongBtn = UIButton(type: .system)
        lastSongBtn.frame = CGRect(x: Device.width/2 - Device.width/3, y: Device.height*4/5 - Device.width/12, width: Device.width/6, height: Device.width/6)
        lastSongBtn.setBackgroundImage(UIImage(named: "previous"), for: .normal)
        self.view.addSubview(lastSongBtn)
        
        nextSongBtn = UIButton(type: .system)
        nextSongBtn.frame = CGRect(x: Device.width/2 + Device.width/3 - Device.width/6, y: Device.height*4/5 - Device.width/12, width: Device.width/6, height: Device.width/6)
        nextSongBtn.setBackgroundImage(UIImage(named: "next"), for: .normal)
        self.view.addSubview(nextSongBtn)
        
        currentTimeLable = UILabel(frame: CGRect(x: Device.width/10, y: Device.height*4/5 - Device.width/10*3+50, width: 48, height: 14))
        currentTimeLable.text = "00:00"
        self.view.addSubview(currentTimeLable)
        
        endTimeLable = UILabel(frame: CGRect(x: Device.width*9/10-48, y: Device.height*4/5 - Device.width/10*3+50, width: 48, height: 14))
        endTimeLable.text = "03:22"
        self.view.addSubview(endTimeLable)
    }
    // MARK: - 初始化播放器
    func setPlayer() {
        let url = URL(string: musicUrl)
        playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem:playerItem!)
        
        // 设置进度条相关属性
        let duration: CMTime = playerItem!.asset.duration
        let seconds: Float64 = CMTimeGetSeconds(duration)
        let secondsInt: Int = Int(seconds)
        playSlider = UISlider(frame: CGRect(x: Device.width/10, y: Device.height*4/5 - Device.width/10*3, width: Device.width*8/10, height: 50))
        playSlider!.minimumValue = 0.0
        playSlider!.maximumValue = Float(seconds)
        playSlider.isContinuous = false
        print(seconds)
        if secondsInt < 60 {
            endTimeLable.text = "00:\(secondsInt)"
        }else if (secondsInt % 60) < 10 && (secondsInt / 60) < 10 {
            endTimeLable.text = "0\(secondsInt % 60):0\(secondsInt / 60)"
        }else if (secondsInt % 60) < 10 && (secondsInt / 60) >= 10 {
            endTimeLable.text = "0\(secondsInt % 60):\(secondsInt / 60)"
        }else if (secondsInt % 60) > 10 && (secondsInt / 60) < 10 {
            endTimeLable.text = "\(secondsInt % 60):0\(secondsInt / 60)"
        }else {
            endTimeLable.text = "\(secondsInt % 60):\(secondsInt / 60)"
        }
        self.view.addSubview(playSlider)
    }
}
