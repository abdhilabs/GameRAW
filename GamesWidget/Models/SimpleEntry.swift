//
//  SimpleEntry.swift
//  FavoriteWidgetExtension
//
//  Created by Abdhi P on 18/09/23.
//

import Domain
import WidgetKit

struct SimpleEntry: TimelineEntry {
  let date: Date
  var item: Game = .init()
  var error: Error?
}

extension SimpleEntry {
  static func build(
    games: [Game],
    refreshInterval: Int
  ) -> [SimpleEntry] {
    let switchBannerInterval = 10
    let repeats = refreshInterval / switchBannerInterval
    let currentDate = Date()
    let totalGames = games.count
    return (0..<repeats).compactMap { index -> SimpleEntry? in
      guard let date = Calendar.current.date(byAdding: .second, value: switchBannerInterval * index, to: currentDate)
      else { return nil }
      return .init(
        date: date,
        item: games[index % totalGames]
      )
    }
  }
}
