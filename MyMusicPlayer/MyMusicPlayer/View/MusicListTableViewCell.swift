//
//  MusicListTableViewCell.swift
//  MyMusicPlayer
//
//  Created by 王春杉 on 2019/2/2.
//  Copyright © 2019 王春杉. All rights reserved.
//

import UIKit
class MusicListTableViewCell: UITableViewCell {
    
    var titleLable = UILabel()
    var coverImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    convenience init(lastestNews: MusicList, index: Int) {
        self.init(style: .default, reuseIdentifier: "MusicListTableViewCell")
        
        let padding: CGFloat = 15
        let border: CGFloat = 65
        
        titleLable.frame = CGRect(x: padding, y: padding, width: Device.width - 3 * padding - border, height: border)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
