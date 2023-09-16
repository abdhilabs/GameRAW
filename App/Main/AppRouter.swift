//
//  AppRouter.swift
//  GameRAW
//
//  Created by Abdhi P on 08/09/23.
//

import Common
import Games
import SwiftUI

@MainActor
extension View {
  func withAppRouter() -> some View {
    navigationDestination(for: NavigationDestination.self) { destination in
      switch destination {
      case let .detailGame(id):
        GameDetailView(id: id)
      }
    }
  }
}
