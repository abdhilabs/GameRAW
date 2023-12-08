//
//  Notifications.swift
//  
//
//  Created by Abdhi P on 07/12/23.
//

import Foundation

public struct Notifications {
  public static let refreshGames = NSNotification.Name(rawValue: "refreshGames")
}

public extension NSNotification.Name {
  func post(with object: Any? = nil) {
    NotificationCenter.default.post(name: self, object: object)
  }
}
