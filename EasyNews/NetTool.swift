//
//  NetTool.swift
//  EasyNews
//
//  Created by mac_zly on 2016/12/9.
//  Copyright © 2016年 zly. All rights reserved.
//

import UIKit

class NetTool: NSObject {
    
    // 天气
    private static let key = "lwcd4mx6yapqcu2c"
    static let baseUrl = "https://api.thinkpage.cn/v3"
    static let weathereUrl = baseUrl + "/weather/daily.json"
    static let currentUrl = baseUrl + "/weather/now.json"
    static let suggestion = baseUrl + "/life/suggestion.json"
    
    static func getWeathereUrlParam(city: String) -> [String : String] {
        return ["key" : key, "language" : "zh-Hans", "unit" : "c", "start" : "0", "day" : "2", "location" : city]
    }
    
    static func getCurrentUrlParam(city: String) -> [String : String] {
        return ["key" : key, "language" : "zh-Hans", "unit" : "c", "location" : city]
    }
    
    static func getSuggestion(city: String) -> [String : String] {
        return ["key" : key, "language" : "zh-Hans", "location" : city]
    }
    
    // 图片 分类
    static let tiangou_image_sort_url = "http://www.tngou.net/tnfs/api/classify"
    // 图片列表
    static let tiangou_image_list_url = "http://www.tngou.net/tnfs/api/list"
    static func getTiangouListURL(id: Int) -> String {
       return getTiangouListURL(id: id, page: 1)
    }
    static func getTiangouListURL(id: Int, page: Int) -> String {
       return getTiangouListURL(id: id, page: page, rows: 20)
    }
    /// 获得图片列表
    ///
    /// - Parameters:
    ///   - id: 图片类型id
    ///   - page: 第几页
    ///   - rows: 一页返回几条数据
    /// - Returns: 返回这个url
    static func getTiangouListURL(id: Int, page: Int , rows: Int) -> String {
        return NetTool.tiangou_image_list_url
            + "?id=" + id.toStringValue
            + "&page=" + page.toStringValue
            + "&rows=" + rows.toStringValue
    }
    
    // 获得图片
    static let tiangou_image_base_url = "http://tnfs.tngou.net/image"
    
    private static func getLanage() -> String {
        if let lanage = Tools.getCurrentLanage() {
            if lanage.hasPrefix("zh") {
                return "zh-Hans"  // 确认是中文
                
            }
        }else {
            return "zh-Hans"  //获得语言失败
        }
        return "en"   // 不是中文
    }
    
    static func toString(any: Any?) -> String {
        if any == nil {
            return "null"
        }
        if any is String {
            return any as! String
        }
        if any is Int {
            return String(any as! Int)
        }
        return "unknow"
    }
    
}
