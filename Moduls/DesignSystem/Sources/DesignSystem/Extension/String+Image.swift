//
//  String+Image.swift
//  GameRAW
//
//  Created by Abdhi P on 18/07/23.
//

import Foundation

public extension String {
  // MARK: - Icons
  static let icApple = "ic-apple"
  static let icNintendo = "ic-nintendo"
  static let icWindows = "ic-windows"
  static let icXbox = "ic-xbox"
  static let icPlaystation = "ic-playstation"
  static let icPhone = "ic-phone"
  static let icLinux = "ic-linux"
  static let icAndroid = "ic-android"
  static let icAmiga = "ic-amiga"
  static let icAtari = "ic-atari"
  static let icSega = "ic-sega"
  
  // MARK: - Images
  static let imgPlaceholder = "img-placeholder"
  
  var iconPlatform: String {
    switch self {
    case "playstation":
      return .icPlaystation
    case "xbox":
      return .icXbox
    case "nintendo":
      return .icNintendo
    case "pc":
      return .icWindows
    case "mac":
      return .icApple
    case "linux":
      return .icLinux
    case "ios":
      return .icPhone
    case "android":
      return .icAndroid
    case "commodore-amiga":
      return .icAmiga
    case "atari":
      return .icAtari
    case "sega":
      return .icSega
    default:
      return ""
    }
  }
}
