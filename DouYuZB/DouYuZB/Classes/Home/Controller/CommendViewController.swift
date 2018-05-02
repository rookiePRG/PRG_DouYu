//
//  CommendViewController.swift
//  DouYuZB
//
//  Created by belief on 2018/4/20.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit
private let kCycleViewH = kScreenW * 3 / 8
private let kGameViewH: CGFloat = 90


class CommendViewController: BaseAnchorViewController {

    //MARK: -lazy
    
    private lazy var commendVM: CommendViewModel = CommendViewModel()

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
        
        collectionView.addSubview(cycleView)
        
        collectionView.addSubview(gameView)
        
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        
    }

}

extension CommendViewController {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell;
            cell.anchor = self.commendVM.dataSource[indexPath.section].room_list[indexPath.row]
            return cell
            
        }else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}


//MARK: - 网络请求
extension CommendViewController {
   
    override func loadData() {
        baseVM = commendVM
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
