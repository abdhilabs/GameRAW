//
//  GameParam.swift
//  GameRAW
//
//  Created by Abdhi P on 19/07/23.
//

import Foundation
import ObjectMapper

public struct GameRequest: Mappable {
  var page: Int = 1
  var pageSize: Int = 10
  var key: String = APIConfiguration.apiKey
  var ordering: String = "-rating"
  
  public init(page: Int, pageSize: Int) {
    self.page = page
    self.pageSize = pageSize
  }
  
  public init?(map: ObjectMapper.Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: ObjectMapper.Map) {
    page <- map["page"]
    pageSize <- map["page_size"]
    key <- map["key"]
    ordering <- map["ordering"]
  }
}
