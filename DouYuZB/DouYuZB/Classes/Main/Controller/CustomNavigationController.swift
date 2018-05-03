//
//  CustomNavigationController.swift
//  DouYuZB
//
//  Created by belief on 2018/5/2.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else {return}
        
        //获取添加系统pop手势的view
        guard let gesView = systemGes.view else {return}
        
        //利用运行时机制查看所有的属性名称
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)
        
        for i in 0..<count {
            let ivar = ivars![Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString: name!))
        }
        */
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject];
        
        guard let targetObjc = targets?.first else {return}
        
        
        //取出target
        guard let target = targetObjc.value(forKey: "target") else {return};
        
        //取出action
        let action = Selector(("handleNavigationTransition:"))
        
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
            
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }

}
