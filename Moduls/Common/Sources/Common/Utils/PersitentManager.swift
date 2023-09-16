//
//  PersitentManager.swift
//  GameRAW
//
//  Created by Abdhi P on 03/08/23.
//

import Foundation

extension String {
  static let username = "username"
  static let email = "email"
}

public struct PersistentManager {
  
  public static func setUsername(value: String) {
    saveString(key: .username, value: value)
  }
  
  public static func getUsername() -> String {
    return getString(key: .username) ?? ""
  }
  
  public static func setEmail(value: String) {
    saveString(key: .email, value: value)
  }
  
  public static func getEmail() -> String {
    return getString(key: .email) ?? ""
  }
  
  private static func getString(key: String) -> String? {
    UserDefaults.standard.string(forKey: key)
  }
  
  private static func saveString(key: String, value: String) {
    UserDefaults.standard.set(value, forKey: key)
  }
}
