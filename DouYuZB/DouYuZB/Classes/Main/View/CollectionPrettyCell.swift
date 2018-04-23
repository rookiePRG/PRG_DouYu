//
//  CollectionPrettyCell.swift
//  DouYuZB
//
//  Created by belief on 2018/4/20.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class CollectionPrettyCell: CollectionBaseCell {

    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor: AnchorModel?{
        didSet{
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
            
        }
    }
    
}
