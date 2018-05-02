//
//  BaseViewModel.swift
//  DouYuZB
//
//  Created by belief on 2018/4/27.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class BaseViewModel {

    //MARK: -lazy
    lazy var dataSource:[AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    
    func requestData(URLString: String, parameters: [String : Any]? = nil, finishCallback : @escaping ()->()) {
        
        NetworkTools.requestData(URLString, requestType: .GET, parameters: parameters, success: { (result) in
            
            let datas = result["data"].array
            for dict in datas! {
                self.dataSource.append(AnchorGroup(json: dict))
            }
            
            finishCallback()
            
        }) {
            print("请求失败!")
        }
        
    }
    
}
