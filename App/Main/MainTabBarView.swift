//
//  MainTabBarView.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import Common
import Games
import Search
import Favorite
import Account
import SwiftUI

public struct MainTabBarView: View {
  
  @StateObject var navigation = NavigationStateManager()
  
  public init() {}
  
  public var body: some View {
    NavigationStack(path: $navigation.path) {
      TabView {
        GamesView()
          .withAppRouter()
          .tabItem {
            Label("tabbar.title.games".localized, systemImage: "gamecontroller")
          }
        
        SearchView()
          .withAppRouter()
          .tabItem {
            Label("tabbar.title.search".localized, systemImage: "magnifyingglass")
          }
        
        FavoriteView()
          .withAppRouter()
          .tabItem {
            Label("tabbar.title.favorite".localized, systemImage: "heart")
          }
        
        ProfileView()
          .tabItem {
            Label("tabbar.title.profile".localized, systemImage: "person")
          }
      }
    }
    .environmentObject(navigation)
  }    
}

struct MainTabBarView_Previews: PreviewProvider {
  static var previews: some View {
    MainTabBarView()
  }
}
