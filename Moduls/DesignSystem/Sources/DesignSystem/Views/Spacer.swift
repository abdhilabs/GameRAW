//
//  Spacer.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import SwiftUI

public struct VerticalSpacer: View {
  private let height: CGFloat
  
  public init(height: CGFloat) {
    self.height = height
  }
  
  public var body: some View {
    Spacer()
      .frame(height: height)
  }
}

public struct HorizontalSpacer: View {
  private let width: CGFloat
  
  public init(width: CGFloat) {
    self.width = width
  }
  
  public var body: some View {
    Spacer()
      .frame(width: width)
  }
}
