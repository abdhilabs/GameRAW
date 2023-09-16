//
//  ParentPlatforms.swift
//  GameRAW
//
//  Created by Abdhi P on 19/07/23.
//

import Foundation
import ObjectMapper

public struct ParentPlatformResponse: Mappable {
  public var platform: PlatformResponse?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    platform <- map["platform"]
  }
}

public struct PlatformResponse: Mappable {
  public var slug: String?
  public var id: Int?
  public var name: String?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    slug <- map["slug"]
    id <- map["id"]
    name <- map["name"]
  }
}
