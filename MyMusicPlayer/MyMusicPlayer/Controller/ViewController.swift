//
//  ViewController.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/1/30.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var rightBarBtn: UIBarButtonItem!
    var musicListTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setMusicList()
        
    }
    
    func setNavigationBar() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "我的音乐"
        rightBarBtn = UIBarButtonItem(title: "我的", style: .plain, target: self, action: #selector(clickRightBarBtn))
        rightBarBtn.tintColor = .black
        self.navigationItem.rightBarButtonItem = rightBarBtn
    }

    func setMusicList() {
        musicListTableView = UITableView(frame: view.bounds)
        view.addSubview(musicListTableView)
        
        musicListTableView.dataSource = self
        musicListTableView.delegate = self
    }
    @objc func clickRightBarBtn() {
        self.navigationController?.pushViewController(MyAccountController(), animated: true)
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
}

