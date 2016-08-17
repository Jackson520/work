//
//  NetWorkTool.swift
//  FuryMusic
//
//  Created by Jackson on 16/7/22.
//  Copyright © 2016年 Changyun Liu. All rights reserved.
//

import UIKit
import AFNetworking

class NetWorkTool: AFHTTPSessionManager {
    
    //定义一个单例
    static var shareNetWorkTool:NetWorkTool = {
       let instance = NetWorkTool()
        return instance
    }()
    
    //定义一个枚举请求方式
    enum requestMethod:String {
    case GET = "GET"
    case POST = "POST"
    }
    
    typealias requestClosure = (respondObject:AnyObject?,error:NSError?) -> ()
    
    /*
    method请求方式
    urlString 请求URl
    parameter 附加参数
    requestFinish 请求成功回调
    */
    
    func httpRequest(method:requestMethod,urlString:String,parameter:[String:AnyObject]?,requestFinish:requestClosure) {
        
        //请求成功和失败闭包的类型可以具体看get和post的方法中的请求成功和失败的闭包类型
        //定义一个请求成功的回调
        let successClosure = {
            (dataTasks:NSURLSessionDataTask,respondData:AnyObject?)
            in
            //请求成功则respondObject有数据。error肯定没数据，给nil
            requestFinish(respondObject: respondData, error: nil)
        }
        //定义请求失败的回调
        let failureClosure = {
            (dataTasks:NSURLSessionDataTask?,error:NSError) -> ()
            in
            //请求失败respondObject没数据，所以给nil，error肯定有数据，所以传给error
            requestFinish(respondObject: nil, error: error)
        }
        
        //区分请求方法
        if method == .GET {
            GET(urlString, parameters: parameter, progress: nil, success: successClosure, failure: failureClosure)
        } else {
            POST(urlString, parameters: parameter, progress: nil, success: successClosure, failure: failureClosure)
        }
       
    }
    
}
