//
//  AmuserViewController.swift
//  DouYuZB
//
//  Created by belief on 2018/4/27.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kMenuH : CGFloat = 200

class AmuserViewController: BaseAnchorViewController {

    fileprivate lazy var amuserVM: AmuserViewModel = AmuserViewModel()
    fileprivate lazy var menuView: AmuserMenuView = {
        let menuView = AmuserMenuView.amuserMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuH, width: kScreenW, height: kMenuH)
        return menuView
    }()
    
}

extension AmuserViewController {
    override func setupUI() {
        super.setupUI()
        self.collectionView.addSubview(menuView)
        self.collectionView.contentInset = UIEdgeInsets(top: kMenuH, left: 0, bottom: 0, right: 0)
    }
}

extension AmuserViewController {
     override func loadData() {
        
        baseVM = amuserVM
        self.amuserVM.requestData {
            self.collectionView.reloadData()
            
            var tempGroups = self.amuserVM.dataSource
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            
            self.loadDataFinished()
            
        }
        
    }
}
