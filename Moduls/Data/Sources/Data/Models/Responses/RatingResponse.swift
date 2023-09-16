//
//  RatingResponse.swift
//  GameRAW
//
//  Created by Abdhi P on 19/07/23.
//

import Foundation
import ObjectMapper

public struct RatingResponse: Mappable {
  public var count: Int?
  public var id: Int?
  public var percent: Double?
  public var title: String?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    count <- map["count"]
    id <- map["id"]
    percent <- map["percent"]
    title <- map["title"]
  }
}
