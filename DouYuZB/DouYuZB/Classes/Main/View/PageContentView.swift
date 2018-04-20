//
//  PageContentView.swift
//  DouYuZB
//
//  Created by change_pan on 2018/4/19.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    //设置滑块
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int)
    //设置按钮
    func pageContentView(targetIndex: Int)
}

private let contentCellID = "contentCellID"

class PageContentView: UIView {
    
    //MARK: - 定义属性
    fileprivate var childVCs : [UIViewController]
    fileprivate weak var  parentVC : UIViewController?
    fileprivate var beginOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate: PageContentViewDelegate?
    
    //MARK: - lazy
    private lazy var collectionView : UICollectionView = { [weak self] in
        
        //创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        //创建collectionView
        let collectionView = UICollectionView(frame: (self?.bounds)!, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellID)
        
        return collectionView
        
        
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, childVCs:[UIViewController], parentVC: UIViewController?) {
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
            parentVC?.addChildViewController(childVC)
        }
        
        //添加collectionView
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
//MARK: - UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false

        beginOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDelegate {return}
        var progress: CGFloat = 0 //滑动比例
        var sourceIndex: Int = 0 //当前选择
        var targetIndex: Int = 0 //目标选择
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        if currentOffsetX > beginOffsetX {//左滑
            progress = currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW)
            sourceIndex = Int(currentOffsetX/scrollViewW)
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childVCs.count {
                targetIndex = childVCs.count - 1
            }
            
            if currentOffsetX - beginOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else {//右滑
            progress = 1 - (currentOffsetX/scrollViewW - floor(currentOffsetX/scrollViewW))
            targetIndex = Int(currentOffsetX/scrollViewW)
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVCs.count {
                sourceIndex = childVCs.count - 1
            }
            
        }

        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.frame.width
        let targetIndex: Int = Int(currentOffsetX/scrollViewW) //当前选择
        delegate?.pageContentView(targetIndex: targetIndex)
    }
}

//MARK: - 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex: Int) {
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
        
    }
}
