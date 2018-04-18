//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by belief on 2018/4/19.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kScrollViewLineH : CGFloat = 2
private let kLabelW : CGFloat = kScreenW / 4.0

class PageTitleView: UIView {

    //MARK: - 定义属性
    private var titles : [String]
    
    //MARK: - lazy
    private lazy var titleLabels : [UILabel] = [UILabel]()
    
    private lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    private lazy var scrollView : UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        scrollview.scrollsToTop = false
        scrollview.bounces = false
        return scrollview
    }()
    
    //MARK: - 自定义构造函数
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        super.init(frame: frame)
        
        //设置UI界面
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageTitleView {
    private func setupUI() {
        //添加scrollView
        scrollView.frame = bounds
        addSubview(scrollView)
        
        //添加title对应的label
        setupTitleLabels()
        
        //设置底部线条和滚动条
        setupBottomLineAndScrollLine()
        
    }
    
    private func setupTitleLabels() {
        
        let labW : CGFloat = kLabelW
        let labH : CGFloat = frame.height - kScrollViewLineH
        let labY : CGFloat = 0
        
        for (index, item) in titles.enumerated() {
            
            let labX : CGFloat = labW * CGFloat(index)
            let lab = UILabel()
            lab.frame = CGRect(x: labX, y: labY, width: labW, height: labH)
            lab.text = item
            lab.textAlignment = .center
            lab.font = UIFont.systemFont(ofSize: 16.0)
            lab.tag = index
            
            scrollView.addSubview(lab)
            titleLabels.append(lab)
        }
        scrollView.contentSize = CGSize(width: CGFloat(titles.count) * labW, height: bounds.height)
    }
    
    private func setupBottomLineAndScrollLine() {
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: kScreenW, height: 0.5)
        addSubview(bottomLine)
        
        let firstLab = titleLabels.first
        firstLab?.textColor = UIColor.orange
        scrollLine.frame = CGRect(x: (firstLab?.frame.origin.x)!, y: frame.height - kScrollViewLineH, width: (firstLab?.frame.width)!, height: kScrollViewLineH)
        scrollView.addSubview(scrollLine)
        
    }
}
