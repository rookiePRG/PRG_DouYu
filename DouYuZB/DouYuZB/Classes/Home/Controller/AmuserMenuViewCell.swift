//
//  AmuserMenuViewCell.swift
//  DouYuZB
//
//  Created by belief on 2018/4/28.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuserMenuViewCell: UICollectionViewCell {

    var groups: [AnchorGroup]?{
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let layoutW = collectionView.bounds.size.width/4
        let layoutH = collectionView.bounds.size.height/2
        
        layout.itemSize = CGSize(width: layoutW, height: layoutH)
        
    }

}

extension AmuserMenuViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        cell.group = groups![indexPath.item]
        return cell
    }
}
