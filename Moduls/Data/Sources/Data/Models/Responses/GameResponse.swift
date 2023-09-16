//
//  GameResponse.swift
//  GameRAW
//
//  Created by Abdhi P on 19/07/23.
//

import Foundation
import ObjectMapper

public struct GameDataResponse: Mappable {
  public var count: Int?
  public var results: [GameResponse]?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    count <- map["count"]
    results <- map["results"]
  }
}

public struct GameResponse: Mappable {
  public var id: Int?
  public var title: String?
  public var backgroundImage: String?
  public var releaseDate: String?
  public var platforms: [ParentPlatformResponse]?
  public var parentPlatforms: [ParentPlatformResponse]?
  public var genres: [GenreResponse]?
  public var rating: Double?
  public var added: Int?
  public var playtime: Int?
  public var metacritic: Int?
  public var reviewsCount: Int?
  public var ratingTop: Int?
  public var ratings: [RatingResponse]?
  public var developers: [DeveloperResponse]?
  public var publishers: [PublisherResponse]?
  public var esrbRating: EsrbRating?
  public var descriptionRaw: String?
  
  public init?(map: Map) {
    mapping(map: map)
  }
  
  public mutating func mapping(map: Map) {
    genres <- map["genres"]
    platforms <- (map["platforms"])
    parentPlatforms <- (map["parent_platforms"])
    rating <- map["rating"]
    backgroundImage <- map["background_image"]
    releaseDate <- map["released"]
    added <- map["added"]
    playtime <- map["playtime"]
    metacritic <- map["metacritic"]
    reviewsCount <- map["reviews_count"]
    id <- map["id"]
    ratingTop <- map["rating_top"]
    title <- map["name"]
    ratings <- map["ratings"]
    esrbRating <- map["esrb_rating"]
    publishers <- map["publishers"]
    developers <- map["developers"]
    descriptionRaw <- map["description_raw"]
  }
}
