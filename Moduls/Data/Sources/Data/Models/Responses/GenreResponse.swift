//
//  GenreResponse.swift
//  GameRAW
//
//  Created by Abdhi P on 20/07/23.
//

import Foundation
import ObjectMapper

public struct GenreResponse: Mappable {
  public var imageBackground: String?
  public var gamesCount: Int?
  public var name: String?
  public var slug: String?
  public var id: Int?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    imageBackground <- map["image_background"]
    gamesCount <- map["games_count"]
    name <- map["name"]
    slug <- map["slug"]
    id <- map["id"]
  }
}
