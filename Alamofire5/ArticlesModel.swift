//
//  ArticlesModel.swift
//  Alamofire5
//
//  Created by Chi Xuan on 09/11/2021.
//

import Foundation

class ArticlesModel: NSObject {
    var title: String = ""
    var thumb: String = ""
    init(json: [String: Any]) {
        if let temp = json["title"] as? String { title = temp }
        if let temp = json["thumb"] as? String { thumb = temp }

    }
}
