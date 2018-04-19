//
//  PageTitleView.swift
//  DouYuZB
//
//  Created by belief on 2018/4/19.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func pageTitleView(_ titleView: PageTitleView, selectIndex: Int)
}

private let kScrollViewLineH : CGFloat = 2
private let kBtnW : CGFloat = kScreenW / 4.0

class PageTitleView: UIView {

    //MARK: - 定义属性
    private var titles : [String]
    private var currentIndex : Int = 0
    weak var delegate: PageTitleViewDelegate?
    
    //MARK: - lazy
    private lazy var titleBtns : [UIButton] = [UIButton]()
    
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
        
        let btnW : CGFloat = kBtnW
        let btnH : CGFloat = frame.height - kScrollViewLineH
        let btnY : CGFloat = 0
        
        for (index, item) in titles.enumerated() {
            
            let btnX : CGFloat = btnW * CGFloat(index)
            let btn = UIButton()
            btn.frame = CGRect(x: btnX, y: btnY, width: btnW, height: btnH )
            btn.setTitle(item, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitleColor(UIColor.orange, for: .selected)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
            btn.tag = index
            if index == 0 {
                btn.isSelected = true
            }
            scrollView.addSubview(btn)
            titleBtns.append(btn)
            btn.addTarget(self, action: #selector(titleLabClick(sender:)), for: .touchUpInside)
            
        }
        scrollView.contentSize = CGSize(width: CGFloat(titles.count) * btnW, height: bounds.height)
    }
    
    private func setupBottomLineAndScrollLine() {
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - 0.5, width: kScreenW, height: 0.5)
        addSubview(bottomLine)
        
        guard let firstBtn = titleBtns.first else { return }
        firstBtn.setTitleColor(UIColor.orange, for: .selected)
        scrollLine.frame = CGRect(x: firstBtn.frame.origin.x, y: frame.height - kScrollViewLineH, width: firstBtn.frame.width, height: kScrollViewLineH)
        scrollView.addSubview(scrollLine)
        
    }
}

//MARK: - label点击事件
extension PageTitleView {
    @objc private func titleLabClick(sender: UIButton){
        
        sender.isSelected = true
        let currentBtn = sender
        if currentBtn.tag == currentIndex {return}
        let oldBtn = titleBtns[currentIndex]
        oldBtn.isSelected = false
        currentIndex = currentBtn.tag
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = CGFloat(currentBtn.tag) * self.scrollLine.frame.width
        }
        delegate?.pageTitleView(self, selectIndex: currentIndex)
    }
}

//MARK: - 对外暴露的方法
extension PageTitleView {
    func setProgress(progress: CGFloat,sourceIndex: Int, targetIndex: Int){
        let sourceBtn = titleBtns[sourceIndex]
        let targetBtn = titleBtns[targetIndex]

        let moveTotalX = targetBtn.frame.origin.x - sourceBtn.frame.origin.x
        let moveX = progress * moveTotalX
        
        scrollLine.frame.origin.x = sourceBtn.frame.origin.x + moveX
    }
    
    func setBtn(targetIndex: Int){
        
        if currentIndex == targetIndex {
            return
        }
        let targetBtn = titleBtns[targetIndex]
        targetBtn.isSelected = true
        let oldBtn = titleBtns[currentIndex]
        oldBtn.isSelected = false
        currentIndex = targetIndex
    }
}
