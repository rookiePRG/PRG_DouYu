//
//  CollectionCycleCell.swift
//  DouYuZB
//
//  Created by belief on 2018/4/24.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var picImageView: UIImageView!
    
    var cycleModel: cycleViewModel? {
        didSet {
            titleLab.text = cycleModel?.title
            picImageView.kf.setImage(with: URL(string: cycleModel?.pic_url ?? ""))
        }
    }
    

}
