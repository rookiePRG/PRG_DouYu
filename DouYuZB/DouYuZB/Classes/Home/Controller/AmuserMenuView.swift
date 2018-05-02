//
//  AmuserMenuView.swift
//  DouYuZB
//
//  Created by belief on 2018/4/28.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"
private let KMenuH : CGFloat = 200

class AmuserMenuView: UIView {

    var groups: [AnchorGroup]?{
        didSet {
            collectionView.reloadData()
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kMenuCellID)
        collectionView.register(UINib(nibName: "AmuserMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: kScreenW, height: KMenuH)
    }
}

extension AmuserMenuView {
    class func amuserMenuView()-> AmuserMenuView {
        return Bundle.main.loadNibNamed("AmuserMenuView", owner: nil, options: nil)?.first as! AmuserMenuView
    }
}

extension AmuserMenuView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil {return 0}
        let pageNum = (groups!.count-1)/8 + 1
        pageControl.numberOfPages = pageNum
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuserMenuViewCell
    
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    private func setupCellDataWithCell(cell : AmuserMenuViewCell, indexPath : IndexPath) {
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2也: 16 ~ 23
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        // 3.取出数据,并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
}

extension AmuserMenuView: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.bounds.size.width)
    }
}
