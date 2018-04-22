//
//  CommendViewModel.swift
//  DouYuZB
//
//  Created by belief on 2018/4/23.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class CommendViewModel {
    
    //MARK: - lazy
    private lazy var dataSource:[AnchorGroup] = [AnchorGroup]()

}

//MARK: - 发送网络请求
extension CommendViewModel {
    func requestData() {
        
        print(Date.getCurrentTime())
        NetworkTools.requestData("http://capi.douyucdn.cn/api/v1/getHotCate", requestType: .GET, parameters: ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()], success: { (resulet) in
            
            let datas = resulet["data"].array
            for dict in datas! {
                self.dataSource.append(AnchorGroup(json: dict))
            }
        }) {
            print("请求失败")
        }
        
    }
}
