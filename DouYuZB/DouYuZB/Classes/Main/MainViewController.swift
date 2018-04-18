//
//  MainViewController.swift
//  DouYuZB
//
//  Created by belief on 2018/4/18.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(tabTitle: "首页", childVC: HomeViewController(), normal_img: "btn_home_normal", selected_img: "btn_home_selected")
        addChildVC(tabTitle: "直播", childVC: LiveViewController(), normal_img: "btn_column_normal", selected_img: "btn_column_selected")
        addChildVC(tabTitle: "关注", childVC: FollowViewController(), normal_img: "btn_live_normal", selected_img: "btn_live_selected")
        addChildVC(tabTitle: "我的", childVC: ProfileViewController(), normal_img: "btn_user_normal", selected_img: "btn_user_selected")
    }

}

//MARK: - 添加子控制器
extension MainViewController {
   fileprivate func addChildVC(tabTitle: String, childVC: UIViewController, normal_img: String, selected_img: String) {
        
        let nav = UINavigationController(rootViewController: childVC)
        childVC.tabBarItem.title = tabTitle
        childVC.tabBarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.orange], for: .selected)
        childVC.tabBarItem.image = UIImage(named: normal_img)
        childVC.tabBarItem.selectedImage = UIImage(named: selected_img)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        self.addChildViewController(nav)
        
        
    }
}
