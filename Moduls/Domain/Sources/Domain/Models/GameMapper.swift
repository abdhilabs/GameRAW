//
//  Mapper.swift
//  GameRAW
//
//  Created by Abdhi P on 20/07/23.
//

import Data

extension GameResponse {
  func toGame(isFavorite: Bool = false) -> Game {
    return Game(
      id: id ?? 0,
      title: title ?? "-",
      backgroundImage: backgroundImage ?? "",
      releaseDate: releaseDate ?? "",
      genres: genres?.map({ $0.name ?? "" }).joined(separator: ", ") ?? "",
      playtime: playtime ?? 0,
      rating: rating ?? 0,
      ratingTop: ratingTop ?? 0,
      description: descriptionRaw ?? "-",
      isFavorite: isFavorite,
      platforms: parentPlatforms?.map({ $0.platform?.slug ?? "" }) ?? [],
      ratings: getRatings(),
      subDetails: getSubDetails())
  }
  
  private func getRatings() -> [SubDetailGame] {
    return ratings?.map({
      SubDetailGame(
        id: getDataRating(rating: $0.title).id,
        title: $0.title?.capitalized ?? "",
        subtitle: "\($0.count ?? 0)",
        iconColor: getDataRating(rating: $0.title).color)
    }) ?? []
  }
  
  private func getDataRating(rating: String?) -> (id: Int, color: String) {
    switch rating {
    case "exceptional":
      return (1, "Green-Theme")
    case "recommended":
      return (2, "Blue-Theme")
    case "meh":
      return (3, "Orange-Theme")
    case "skip":
      return (4, "Red-Theme")
    default:
      return (5, "")
    }
  }
  
  private func getColorMetacritic(rating: Int) -> String {
    switch rating {
    case 75...100:
      return "Green-Theme"
    case 50...74:
      return "Yellow-Theme"
    case ..<49:
      return "Red-Theme"
    default:
      return ""
    }
  }
  
  private func getSubDetails() -> [SubDetailGame] {
    var items: [SubDetailGame] = []
    
    let platforms = platforms?.map({ $0.platform?.name ?? "" }).joined(separator: ", ") ?? ""
    let metacritic = metacritic ?? 0
    let genres = genres?.map({ $0.name ?? "" }).joined(separator: ", ") ?? ""
    let releaseDate = releaseDate ?? ""
    let developers = developers?.map({ $0.name ?? "" }).joined(separator: ", ") ?? ""
    let publishers = publishers?.map({ $0.name ?? "" }).joined(separator: ", ") ?? ""
    let esrbRating = esrbRating?.name ?? "game.detail.content.not-rated"
    
    items.append(.init(id: 1, title: "game.detail.content.title.platforms", subtitle: platforms))
    if metacritic != 0 {
      items.append(.init(id: 2, title: "game.detail.content.title.metascore", subtitle: "\(metacritic)", iconColor: getColorMetacritic(rating: metacritic)))
    }
    if !genres.isEmpty {
      items.append(.init(id: 3, title: "game.detail.content.title.genre", subtitle: genres))
    }
    if !releaseDate.isEmpty {
      items.append(.init(id: 4, title: "game.detail.content.title.release-date", subtitle: releaseDate))
    }
    items.append(.init(id: 5, title: "game.detail.content.title.developer", subtitle: developers))
    if !publishers.isEmpty {
      items.append(.init(id: 6, title: "game.detail.content.title.publisher", subtitle: publishers))
    }
    items.append(.init(id: 7, title: "game.detail.content.title.age-rating", subtitle: esrbRating))
    return items
  }
}

extension Game {
  public func toGameEntityRequest() -> GameEntityRequest {
    return GameEntityRequest(
      id: id,
      title: title,
      backgroundImage: backgroundImage,
      releaseDate: releaseDate,
      genres: genres,
      platforms: platforms,
      playtime: playtime,
      rating: rating,
      ratingTop: ratingTop,
      description: description,
      ratings: ratings.map({ $0.toSubDetailGameEntityRequest() }),
      subDetails: subDetails.map({ $0.toSubDetailGameEntityRequest() }))
  }
}

extension SubDetailGame {
  public func toSubDetailGameEntityRequest() -> SubDetailGameEntityRequest {
    return SubDetailGameEntityRequest(
      id: id,
      title: title,
      subtitle: subtitle,
      iconColor: iconColor)
  }
}

extension GameEntity {
  public func toGame() -> Game {
    return Game(
      id: Int(id),
      title: title ?? "",
      backgroundImage: backgroundImage ?? "",
      releaseDate: releaseDate ?? "",
      genres: genres ?? "",
      playtime: Int(playtime),
      rating: rating,
      ratingTop: Int(ratingTop),
      description: descriptionRaw ?? "",
      isFavorite: true,
      platforms: (platforms?.allObjects as? [PlatformsEntity] ?? []).map({ $0.name ?? "" }),
      ratings: (ratings?.allObjects as? [SubDetailGameEntity] ?? []).map({ $0.toSubDetailGame() }),
      subDetails: (subDetails?.allObjects as? [SubDetailGameEntity] ?? [])
        .map({ $0.toSubDetailGame() })
        .sorted(by: { $0.id < $1.id }))
  }
  
  public func saveGame(with item: Game) {
    
  }
}

extension SubDetailGameEntity {
  public func toSubDetailGame() -> SubDetailGame {
    return SubDetailGame(
      id: Int(id),
      title: title ?? "",
      subtitle: subtitle ?? "",
      iconColor: iconColor ?? "")
  }
}
