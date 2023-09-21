//
//  GamesWidget.swift
//  GamesWidget
//
//  Created by Abdhi P on 21/09/23.
//

import Dependiject
import Domain
import Intents
import SwiftUI
import WidgetKit

struct Provider: IntentTimelineProvider {
  
  @Store private var viewModel = Factory.shared.resolve(WidgetGamesViewModel.self)
  
  func placeholder(in context: Context) -> SimpleEntry {
    return SimpleEntry(date: Date(), item: .init(
      id: 0,
      title: "Red Dead Redemption 2",
      releaseDate: "2018-10-26",
      genres: "Action, Adventure",
      platforms: ["pc", "playstation", "xbox"]))
  }
  
  func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> Void) {
    let entry = SimpleEntry(date: Date(), item: .init(
      id: 0,
      title: "Red Dead Redemption 2",
      releaseDate: "2018-10-26",
      genres: "Action, Adventure",
      platforms: ["pc", "playstation", "xbox"]))
    completion(entry)
  }
  
  func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
    viewModel.getFavoriteGames { games, error in
      if error == nil {
        let refreshInterval = 1 * 60 * 60 // Reload API after 1h
        let entries = SimpleEntry.build(
          games: games,
          refreshInterval: refreshInterval
        )
        let refreshDate = Calendar.current.date(byAdding: .second, value: refreshInterval, to: Date()) ?? Date()
        completion(Timeline(entries: entries, policy: .after(refreshDate)))
      } else {
        let retryDate = Calendar.current.date(byAdding: .minute, value: 5, to: Date()) ?? Date() // Retry after 5m
        completion(Timeline(entries: [SimpleEntry(date: Date(), error: error)], policy: .after(retryDate)))
      }
    }
  }
}

struct GamesWidget: Widget {
  let kind: String = "GamesWidget"
  
  var body: some WidgetConfiguration {
    IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
      GamesWidgetView(entry: entry)
    }
    .configurationDisplayName("widget.placeholder.title".localized)
    .description("widget.placeholder.subtitle".localized)
    .supportedFamilies([.systemSmall])
  }
}
