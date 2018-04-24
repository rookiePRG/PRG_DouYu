//
//  CommendViewController.swift
//  DouYuZB
//
//  Created by belief on 2018/4/20.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kItemMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 3*kItemMargin)/2
private let kNormalItemH : CGFloat = kItemW * 3/4
private let kPrettyItemH : CGFloat = kItemW * 4/3
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"

private let kHeaderViewID = "kHeaderViewID"

class CommendViewController: UIViewController {

    //MARK: -lazy
    
    private lazy var commendVM: CommendViewModel = CommendViewModel()
    
    private lazy var collectionView: UICollectionView = {[unowned self] in
        
        //创建Layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: 50)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        //创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        
        return collectionView
        
        
    }()
    
    private lazy var cycleView: CommendCycleView = {
        
        let cycleView = CommendCycleView.commendCycleView()
        cycleView.frame = CGRect(x: 0, y: -kCycleViewH-kGameViewH, width: kScreenW, height: kCycleViewH)
        cycleView.backgroundColor = UIColor.red
        return cycleView
        
    }()
    
    private lazy var gameView: CommendGameView = {
        let gameView = CommendGameView.commendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        gameView.backgroundColor = UIColor.red
        return gameView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.addSubview(collectionView)
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        
        //网络请求
        loadData()
    }

}

extension CommendViewController : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.commendVM.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = self.commendVM.dataSource[section]
        return group.room_list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let group = self.commendVM.dataSource[indexPath.section]
        let anchor = group.room_list[indexPath.item]
        
        
        var cell : CollectionBaseCell!
        
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        
        cell.anchor = anchor
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        //取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        let group = self.commendVM.dataSource[indexPath.section]
        headerView.group = group
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
}

//MARK: - 网络请求
extension CommendViewController {
   
    private func loadData() {
        commendVM.requestData {
            self.collectionView.reloadData()
            
            // 2.将数据传递给GameView
            var groups = self.commendVM.dataSource
            
            // 2.1.移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            
            // 2.2.添加更多组
            var moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            
            self.gameView.groups = groups
            
        }
        
        commendVM.requestCycleViewData {
            self.cycleView.cycleModels = self.commendVM.cycleSource
        }
    }
    
}
