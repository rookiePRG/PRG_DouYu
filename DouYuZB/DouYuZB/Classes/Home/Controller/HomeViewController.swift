//
//  HomeViewController.swift
//  DouYuZB
//
//  Created by belief on 2018/4/18.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

private let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {

    //MARK: - lazy
    private lazy var pageTitleView : PageTitleView = {
        let titleView_frame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩","网游","竞技","绝地","求生"]
        let pageTitleView = PageTitleView(frame: titleView_frame, titles: titles)
        return pageTitleView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
    }

}

//MARK: - 设置UI界面
extension HomeViewController {
    private func setupUI() {
        
        automaticallyAdjustsScrollViewInsets = false
        //设置导航栏
        setupNavigationBar()
        
        //添加TtileView
        view.addSubview(pageTitleView)
    }
    
    private func setupNavigationBar() {
        
        //设置左侧的item
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        
        //设置右侧的item
        let size = CGSize(width: 40, height: 40)
        let history_item = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let search_item = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let scan_item = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems = [history_item, search_item, scan_item]
    }
    
    private func setupTitleView() {
        
        
        
    }
}
