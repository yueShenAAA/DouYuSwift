//
//  NetworkingTools.swift
//  AlamofireDemo
//
//  Created by l on 2018/7/19.
//  Copyright © 2018年 l. All rights reserved.
//

import UIKit
import Alamofire

enum MethodType {
    case GET
    case POST
}
class NetworkingTools {

    class func requestData(type:MethodType,URLSting:String,parameters:[String:String]? = nil,finshedCallBack:@escaping (_ result:AnyObject) -> ()){
        
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        let encoding:URLEncoding = .default
        let headers:HTTPHeaders = ["Content-Type":"application/json"]
        
        Alamofire.request(URLSting, method: method, parameters: parameters, encoding: encoding, headers: headers).responseJSON { (dataResponse) in
            
            guard dataResponse.result.value != nil else{
                return
            }
            finshedCallBack(dataResponse.result.value as AnyObject)
            
        }
        
        
    }
}
