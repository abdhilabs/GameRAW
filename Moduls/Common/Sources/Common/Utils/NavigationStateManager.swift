//
//  NavigationStateManager.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import SwiftUI

@MainActor
public class NavigationStateManager: ObservableObject {
  
  @Published public var path: [NavigationDestination] = []
  
  public init() {}
  
  public func navigate(to destination: NavigationDestination) {
    path.append(destination)
  }
  
  public func popToRoot() {
    path = []
  }
}

public enum NavigationDestination: Hashable {
  case detailGame(id: Int)
}
