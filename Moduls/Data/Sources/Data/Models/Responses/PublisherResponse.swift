//
//  PublisherResponse.swift
//  GameRAW
//
//  Created by Abdhi P on 23/07/23.
//

import Foundation
import ObjectMapper

public struct PublisherResponse: Mappable {
  public var id: Int?
  public var name: String?
  public var slug: String?
  public var gamesCount: Int?
  public var imageBackground: String?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    slug <- map["slug"]
    gamesCount <- map["games_count"]
    imageBackground <- map["image_background"]
  }
}
