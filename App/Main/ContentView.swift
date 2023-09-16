//
//  ContentView.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import Common
import SwiftUI

struct ContentView: View {
  
  @StateObject var navigation = NavigationStateManager()
  
  var body: some View {
    NavigationStack(path: $navigation.path) {
      MainTabBarView()
    }
    .environmentObject(navigation)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
