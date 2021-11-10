//
//  ArticlesModel.swift
//  Alamofire5
//
//  Created by daona on 09/11/2021.
//

import Foundation

class ArticlesModel: Decodable {
    var id: Int = 0
    var title: String = ""
    var thumb: String = ""
    var url: String = ""
    var sourceURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case thumb = "thumb"
        case url = "url"
        case sourceURL = "source_url"
    }
    
    init() {}

    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(Int.self, forKey: .id)
        self.title = try value.decode(String.self, forKey: .title)
        self.thumb = try value.decode(String.self, forKey: .thumb)
        self.url = try value.decode(String.self, forKey: .url)
        self.sourceURL = try value.decodeIfPresent(String.self, forKey: .sourceURL)
    }
}
