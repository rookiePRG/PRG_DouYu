//
//  CycleViewModel.swift
//  DouYuZB
//
//  Created by belief on 2018/4/24.
//  Copyright © 2018年 PRG. All rights reserved.
//

import SwiftyJSON

struct cycleViewModel {
    
    var title : String?
    var pic_url : String?
    var room : AnchorModel = AnchorModel()
    
    init() {
        
    }
    
    init(json:JSON!) {
        
        title = json!["title"].stringValue
        pic_url = json!["pic_url"].stringValue
        room = AnchorModel(json: json!["room"])
        
    }
}
