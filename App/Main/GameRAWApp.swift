//
//  GameRAWApp.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import SwiftUI
import netfox

@main
struct GameRAWApp: App {
  
  init() {
    FactoryInjection.shared.inject()
  }
  
  var body: some Scene {
    WindowGroup {
      MainTabBarView()
        .onAppear {
          NFX.sharedInstance().start()
          UITabBar.appearance().isTranslucent = false
        }
    }
  }
}
