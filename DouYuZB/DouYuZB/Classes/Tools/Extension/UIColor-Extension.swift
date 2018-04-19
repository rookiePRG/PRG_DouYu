//
//  UIColor-Extension.swift
//  DouYuZB
//
//  Created by change_pan on 2018/4/19.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

extension UIColor {
    
    //MARK: - RGB设置颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
}
