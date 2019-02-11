//
//  DetailMuiscListTableViewCell.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/2/10.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit
class DetailMuiscListTableViewCell: UITableViewCell {
    var titleLable = UILabel()
    var locIndexLable = UILabel()
    var singerNameLable = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(detailMusic: DetailMusic, index: Int) {
        self.init(style: .default, reuseIdentifier: "DetaileMusicListTableViewCell")
        
        let padding: CGFloat = 15
        let border: CGFloat = 44
        
        locIndexLable.frame = CGRect(x: padding, y: padding, width: 30, height: 25)
        locIndexLable.text = "\(index+1)"
        locIndexLable.textAlignment = .center
        locIndexLable.font = UIFont.systemFont(ofSize: 20)
        locIndexLable.textColor = .gray
        contentView.addSubview(locIndexLable)
        
        titleLable.frame = CGRect(x: padding+30, y: padding-8, width: Device.width - 3 * padding - border, height: 23)
        titleLable.text = detailMusic.detailMusicInfo[index].name
        titleLable.font = UIFont.systemFont(ofSize: 21)
        contentView.addSubview(titleLable)
        
        singerNameLable.frame = CGRect(x: padding+30, y: padding-8+23, width: Device.width - 3 * padding - border, height: 20)
        singerNameLable.textColor = .gray
        singerNameLable.text = detailMusic.detailMusicInfo[index].singerName
        singerNameLable.font = UIFont.systemFont(ofSize: 16)
        contentView.addSubview(singerNameLable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
