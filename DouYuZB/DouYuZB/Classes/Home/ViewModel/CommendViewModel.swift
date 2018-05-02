//
//  CommendViewModel.swift
//  DouYuZB
//
//  Created by belief on 2018/4/23.
//  Copyright © 2018年 PRG. All rights reserved.
//

import UIKit

class CommendViewModel: BaseViewModel {
    
    //MARK: - lazy
    lazy var cycleSource:[cycleViewModel] = [cycleViewModel]()
    private var hotDataGroup: AnchorGroup = AnchorGroup()
    private var prettyDataGroup: AnchorGroup = AnchorGroup()
    
}

//MARK: - 发送网络请求
extension CommendViewModel {
    func requestData(_ finishCallback : @escaping ()->()) {
        
        //1.定义参数
        let parameters = ["limit" : "4", "offset" : "0", "time" : Date.getCurrentTime()]
        
        //2.创建组
        let dGroup = DispatchGroup()
        
        
        //3.获取热门组数据
        
        //3.1加入组
        dGroup.enter();
        NetworkTools.requestData("http://capi.douyucdn.cn/api/v1/getbigDataRoom", requestType: .GET, parameters: ["time": Date.getCurrentTime()], success: { (result) in
            
            //3.2数据转模型
            let datas = result["data"].array
            
            //3.3 设置组的属性
            self.hotDataGroup.tag_name = "热门"
            self.hotDataGroup.icon_name = "home_header_hot"
            
            for dict in datas! {
                self.hotDataGroup.room_list.append(AnchorModel(json: dict))
            }
            
            //3.3离开组
            dGroup.leave()
            
        }) {
            print("请求失败");
            dGroup.leave()
        }
        
        //4.获取颜值组数据
        //4.1 加入组
        dGroup.enter()
        NetworkTools.requestData("http://capi.douyucdn.cn/api/v1/getVerticalRoom", requestType: .GET, parameters: parameters, success: { (result) in
            
            //4.2 数据转模型
            let datas = result["data"].array
            
            //4.3 设置组的属性
            self.prettyDataGroup.tag_name = "颜值"
            self.prettyDataGroup.icon_name = "home_header_phone"
            
            for dict in datas! {
                self.prettyDataGroup.room_list.append(AnchorModel(json: dict))
            }
            
            //4.3离开组
            dGroup.leave()
        }) {
            print("请求失败")
            dGroup.leave()
        }
        
        
        
        //5.获取2-12组的数据
        //5.1 加入组
        dGroup.enter()
        
        requestData(URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
        
        //6.获取到所有数据后排序
        dGroup.notify(queue: DispatchQueue.main) {
            self.dataSource.insert(self.prettyDataGroup, at: 0)
            self.dataSource.insert(self.hotDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    func requestCycleViewData(_ finishCallback : @escaping ()->()) {
        //获取轮播图数据
        NetworkTools.requestData("http://www.douyutv.com/api/v1/slide/6", requestType: .GET, parameters:["version" : "2.300"], success: { (result) in
            
            //数据转模型
            let datas = result["data"].array
            for dic in datas! {
                
                self.cycleSource.append(cycleViewModel(json: dic))
            }
            
            finishCallback()
            
        }) {
            print("请求失败")
        }
        
        
    }
}
