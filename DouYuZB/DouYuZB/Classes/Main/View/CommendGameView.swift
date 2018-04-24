//
//  CommendGameView.swift
//  DouYuZB
//
//  Created by belief on 2018/4/24.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class CommendGameView: UIView {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var groups: [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
    }

}

//快速创建View的类方法
extension CommendGameView {
    
    class func commendGameView() -> CommendGameView {
        return Bundle.main.loadNibNamed("CommendGameView", owner: nil, options: nil)?.first as! CommendGameView
    }
    
}

extension CommendGameView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.group = groups![indexPath.item]
        
        
        
        return cell
    }
}
