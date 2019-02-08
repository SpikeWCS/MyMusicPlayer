//
//  LoginController.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/2/4.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit
import SDWebImage

class MainController: UIViewController {
    
    var rightBarBtn: UIBarButtonItem!
    var musicListTableView = UITableView()
    var musicList: MusicList!
    var listCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        setNavigationBar()
        MusicListHelper.getMusicList(success: { musicList in
            self.musicList = musicList
            print("MusicList成功：\(musicList.playlist.count)")
            self.listCount = musicList.playlist.count
            self.setMusicList()
        }) { _ in
            
        }
        
    }
    
    func setNavigationBar() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "我的音乐"
        rightBarBtn = UIBarButtonItem(title: "我的", style: .plain, target: self, action: #selector(clickRightBarBtn))
        rightBarBtn.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }
    
    func setMusicList() {
        musicListTableView = UITableView(frame: view.bounds, style: .grouped)
        view.addSubview(musicListTableView)
        
        musicListTableView.dataSource = self
        musicListTableView.delegate = self
    }
    @objc func clickRightBarBtn() {
        self.navigationController?.pushViewController(MyAccountController(), animated: true)
        
    }
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "我创建的歌单(\(listCount))"
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.playlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = UITableViewCell()
        tableViewCell.accessoryType = .disclosureIndicator
        print(indexPath.row)
        tableViewCell.textLabel?.text = musicList.playlist[indexPath.row].name
        tableViewCell.imageView?.sd_setImage(with: URL(string: musicList.playlist[indexPath.row].coverImgURL))
        return tableViewCell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        DetailMusicId.id = musicList.playlist[indexPath.row].id
        self.navigationController?.pushViewController(DetailMusicController(), animated: true)
    }
}
