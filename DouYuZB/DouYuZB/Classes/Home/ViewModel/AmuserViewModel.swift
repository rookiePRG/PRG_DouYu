//
//  AmuserViewModel.swift
//  DouYuZB
//
//  Created by belief on 2018/4/27.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class AmuserViewModel: BaseViewModel {

    
}

extension AmuserViewModel {
    
    func requestData(finishCallback : @escaping ()->()) {

        requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishCallback: finishCallback)
        
    }
    
}
