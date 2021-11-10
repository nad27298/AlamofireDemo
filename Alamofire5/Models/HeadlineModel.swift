//
//  HeadlineModel.swift
//  Alamofire5
//
//  Created by daona on 10/11/2021.
//

import Foundation

class HeadlineModel: Decodable {
    var id: Int = 0
    var uuid: Int = 0
    var next: String = ""
    var articles: [ArticlesModel] = []
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case uuid = "uuid_id"
        case next = "next"
        case articles = "articles"
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let value = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try value.decode(Int.self, forKey: .id)
        self.uuid = try value.decode(Int.self, forKey: .uuid)
        self.next = try value.decode(String.self, forKey: .next)
        self.articles = try value.decode([ArticlesModel].self, forKey: .articles)
    }
    
}
