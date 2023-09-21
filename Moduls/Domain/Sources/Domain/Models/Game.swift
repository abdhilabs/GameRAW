//
//  Game.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import SwiftUI

public struct Game: Hashable {
  public var id: Int = 0
  public var title: String = ""
  public var backgroundImage: String = ""
  public var releaseDate: String = ""
  public var genres: String = ""
  public var platforms: [String] = []
  public var playtime: Int = 0
  public var rating: Double = 0.0
  public var ratingTop: Int = 0
  public var description: String = ""
  public var ratings: [SubDetailGame] = []
  public var subDetails: [SubDetailGame] = []
  
  public init() {}
  
  public init(
    id: Int,
    title: String,
    backgroundImage: String = "",
    releaseDate: String = "",
    genres: String = "",
    playtime: Int = 0,
    rating: Double = 0.0,
    ratingTop: Int = 0,
    description: String = "",
    platforms: [String] = [],
    ratings: [SubDetailGame] = [],
    subDetails: [SubDetailGame] = []) {
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

public struct SubDetailGame: Hashable {
  public var id: Int = 0
  public var title: String
  public var subtitle: String
  public var iconColor: String = ""
}
