//
//  UIScreen.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import SwiftUI

public extension UIScreen {
  static var safeAreaInsets: UIEdgeInsets? {
    return UIApplication.shared.windows.first?.safeAreaInsets
  }
  
  static var screenWidth: CGFloat {
    if UIDevice.current.orientation.isLandscape {
      return max(UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width)
    } else {
      return min(UIScreen.main.bounds.size.height, UIScreen.main.bounds.size.width)
    }
  }
  
  static var screenHeight: CGFloat {
    if UIDevice.current.orientation.isLandscape {
      return max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    } else {
      return max(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
    }
  }
}
