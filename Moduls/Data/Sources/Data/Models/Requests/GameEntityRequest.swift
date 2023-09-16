//
//  GameEntityRequest.swift
//  Data
//
//  Created by Abdhi P on 31/08/23.
//

import Foundation

public struct GameEntityRequest {
  public var id: Int
  public var title: String
  public var backgroundImage: String
  public var releaseDate: String
  public var genres: String
  public var platforms: [String]
  public var playtime: Int
  public var rating: Double
  public var ratingTop: Int
  public var description: String
  public var ratings: [SubDetailGameEntityRequest]
  public var subDetails: [SubDetailGameEntityRequest]
  
  public init(
    id: Int,
    title: String,
    backgroundImage: String,
    releaseDate: String,
    genres: String,
    platforms: [String],
    playtime: Int,
    rating: Double,
    ratingTop: Int,
    description: String,
    ratings: [SubDetailGameEntityRequest],
    subDetails: [SubDetailGameEntityRequest]) {
      self.id = id
      self.title = title
      self.backgroundImage = backgroundImage
      self.releaseDate = releaseDate
      self.genres = genres
      self.platforms = platforms
      self.playtime = playtime
      self.rating = rating
      self.ratingTop = ratingTop
      self.description = description
      self.ratings = ratings
      self.subDetails = subDetails
    }
}

public struct SubDetailGameEntityRequest {
  public var id: Int
  public var title: String
  public var subtitle: String
  public var iconColor: String
  
  public init(id: Int, title: String, subtitle: String, iconColor: String) {
    self.id = id
    self.title = title
    self.subtitle = subtitle
    self.iconColor = iconColor
  }
}
