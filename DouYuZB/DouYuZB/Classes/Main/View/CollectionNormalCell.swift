//
//  CollectionNormalCell.swift
//  DouYuZB
//
//  Created by belief on 2018/4/20.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class CollectionNormalCell: CollectionBaseCell {

    @IBOutlet weak var roomNameLab: UILabel!
    
    override var anchor : AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            
            roomNameLab.text = anchor?.room_name
            
        }
    }
}
