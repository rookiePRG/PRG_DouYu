//
//  AnchorGroup.swift
//  DouYuZB
//
//  Created by belief on 2018/4/23.
//  Copyright © 2018年 PRG. All rights reserved.
//

import SwiftyJSON

struct AnchorGroup {
    
    var tag_name: String?
    var icon_name: String = "home_header_normal"
    var room_list: [AnchorModel] = [AnchorModel]()
    
    init(json:JSON?) {
        
        tag_name = json!["tag_name"].stringValue
        
        let roomList = json!["room_list"].array
        for dict in roomList! {
            room_list.append(AnchorModel.init(json: dict))
        }
    }
    
}

struct AnchorModel {
    
    var room_id: String?
    var vertical_src: String?
    var isVertical: String?
    var room_name: String?
    var nickname: String?
    var online: String?
    
    init(json:JSON?) {
        
        room_id = json!["room_id"].stringValue
        vertical_src = json!["vertical_src"].stringValue
        isVertical = json!["isVertical"].stringValue
        room_name = json!["room_name"].stringValue
        nickname = json!["nickname"].stringValue
        online = json!["online"].stringValue
    }
    
}
