//
//  GameViewController.swift
//  DouYuZB
//
//  Created by belief on 2018/4/25.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemW: CGFloat = (kScreenW - 2*kItemMargin)/3
private let kItemH: CGFloat = kItemW*6/5
private let kHeaderViewH : CGFloat = 50

private let kGameCellID = "kGameCellID"
private let kGameHeaderID = "kGameHeaderID"
private let kGameViewH: CGFloat = 90

class GameViewController: UIViewController {

    //MARK: -懒加载
    fileprivate lazy var collectionView: UICollectionView = {[unowned self] in
        
        //创建Layout
        let  layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        
        //创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderID)
        
        return collectionView
        
    }()
    
    fileprivate lazy var topHeaderView: CollectionHeaderView = {
        
        let topHeaderView = CollectionHeaderView.collectionHeaderView()
        topHeaderView.frame = CGRect(x: 0, y: -kHeaderViewH-kGameViewH, width: kScreenW, height: kHeaderViewH)
        topHeaderView.iconImageView.image = UIImage(named: "Img_orange")
        topHeaderView.titleLab.text = "常见"
        topHeaderView.moreBtn.isHidden = true
        return topHeaderView
        
    }()
    
    fileprivate lazy var gameView: CommendGameView = {
        
        let gameView = CommendGameView.commendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    //MARK: -系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.red
        
        setupUI()
        
    }

}

//MARK: - 设置UI界面
extension GameViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
        
        collectionView.addSubview(topHeaderView)
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kHeaderViewH+kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameHeaderID, for: indexPath) as! CollectionHeaderView
        
        headerView.titleLab.text = "全部"
        headerView.iconImageView.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}
