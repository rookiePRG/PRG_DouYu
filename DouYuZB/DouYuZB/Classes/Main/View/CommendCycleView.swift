//
//  CommendCycleView.swift
//  DouYuZB
//
//  Created by belief on 2018/4/24.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kCycleViewCellID = "kCycleViewCellID"

class CommendCycleView: UIView {
    
    //MARK: 定义属性
    var cycleModels : [cycleViewModel]? {
        didSet {
            collectionView.reloadData()
            pageControl.numberOfPages = cycleModels?.count ?? 0
        }
    }

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        autoresizingMask = UIViewAutoresizing()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleViewCellID)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
    }
}

// MARK:- 提供一个快速创建View的类方法
extension CommendCycleView {
    
    class func commendCycleView() -> CommendCycleView {
        
        return Bundle.main.loadNibNamed("CommendCycleView", owner: nil, options: nil)?.first as! CommendCycleView
        
    }
    
}

extension CommendCycleView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleViewCellID, for: indexPath)
        
        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        return cell
    }
    
}
