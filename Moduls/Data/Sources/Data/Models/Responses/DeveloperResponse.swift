//
//  DeveloperResponse.swift
//  GameRAW
//
//  Created by Abdhi P on 22/07/23.
//

import Foundation
import ObjectMapper

public struct DeveloperResponse: Mappable {
  public var gamesCount: Int?
  public var name: String?
  public var slug: String?
  public var imageBackground: String?
  public var id: Int?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    gamesCount <- map["games_count"]
    name <- map["name"]
    slug <- map["slug"]
    imageBackground <- map["image_background"]
    id <- map["id"]
  }
}
