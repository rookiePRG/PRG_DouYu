//
//  PageContentView.swift
//  DouYuZB
//
//  Created by change_pan on 2018/4/19.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    //MARK: - 定义属性
    private var childVCs : [UIViewController]
    private var  parentVC : UIViewController
    
    //MARK: - lazy
    private lazy var collectionView : UICollectionView = {
        
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建collectionView
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
        
        
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, childVCs:[UIViewController], parentVC: UIViewController) {
        self.childVCs = childVCs
        self.parentVC = parentVC
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - 设置UI界面
extension PageContentView {
    
    func setupUI(){
        
        //将所有的子控制器添加到父控制器
        for childVC in childVCs {
            parentVC.addChildViewController(childVC)
        }
        
        //添加collectionView
        collectionView.frame = bounds
        addSubview(collectionView)
        
    }
    
}

//MARK: - UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVCs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellID, for: indexPath)
        
        //给cell添加内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVC = childVCs[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        return cell
        
    }
}
