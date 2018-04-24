//
//  CollectionGameCell.swift
//  DouYuZB
//
//  Created by belief on 2018/4/24.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    var group: AnchorGroup? {
        didSet {
            titleLab.text = group?.tag_name
            
            if let iconURL = URL(string: group?.icon_url ?? "") {
                iconImageView.kf.setImage(with: iconURL)
            } else {
                iconImageView.image = UIImage(named: "home_more_btn")
            }
        }
    }
    

}
