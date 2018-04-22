//
//  NSDate-Extension.swift
//  DouYuZB
//
//  Created by belief on 2018/4/23.
//  Copyright © 2018年 PRG. All rights reserved.
//

import Foundation

extension Date {
    
    //MARK: 获取当前时间
    static func getCurrentTime() -> String {
        let nowDate = Date()
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
    
}
