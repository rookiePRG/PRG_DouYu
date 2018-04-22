//
//  NetworkTools.swift
//  DouYuZB
//
//  Created by belief on 2018/4/18.
//  Copyright © 2018年 PRG. All rights reserved.
//

import Alamofire
import SwiftyJSON

enum MethodType {
    case GET
    case POST
}

typealias RGAlamofireRequsetSuccess = (_ json: JSON) -> Void
typealias RGAlamofireRequsetFailure = () -> Void

class NetworkTools {
    
    class func requestData(_ url: String, requestType: MethodType, parameters: [String : Any]? = nil, success: RGAlamofireRequsetSuccess?, failure: RGAlamofireRequsetFailure?) {
        
        let method = requestType == .GET ? HTTPMethod.get : HTTPMethod.post
        print("请求接口:-----\(url)------请求参数:->\(String(describing: parameters))")
        Alamofire.request(url, method: method, parameters: parameters).responseJSON { (response) in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if success != nil {
                    success!(json)
                }
            case .failure(let error):
                print(error)
                if failure != nil {
                    failure!()
                }
            }
        }
        
    }
    
}
