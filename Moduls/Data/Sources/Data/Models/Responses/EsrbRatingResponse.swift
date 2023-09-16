//
//  EsrbRatingResponse.swift
//  GameRAW
//
//  Created by Abdhi P on 23/07/23.
//

import Foundation
import ObjectMapper

public struct EsrbRating: Mappable {
  public var id: Int?
  public var name: String?
  public var slug: String?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    id <- map["id"]
    name <- map["name"]
    slug <- map["slug"]
  }
}
