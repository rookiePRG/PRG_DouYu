//
//  CollectionBaseCell.swift
//  DouYuZB
//
//  Created by belief on 2018/4/24.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
 
    @IBOutlet weak var nickNameLab: UILabel!
    @IBOutlet weak var srcImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UIButton!
    
    var anchor: AnchorModel? {
        didSet {
            guard let anchor = anchor else {return}
            nickNameLab.text = anchor.nickname
            
            var onlineStr: String = ""
            if anchor.online! >= 10000 {
                onlineStr = "\(anchor.online!/10000)万在线"
            } else {
                onlineStr = "\(anchor.online!)在线"
            }
            
            onlineBtn.setTitle(onlineStr, for: .normal)
            
            guard let srcURL = URL(string: anchor.vertical_src!) else {return}
            srcImageView.kf.setImage(with: srcURL)
        }
    }
    
    
}
