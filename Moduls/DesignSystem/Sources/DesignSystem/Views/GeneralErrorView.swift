//
//  GeneralErrorView.swift
//  GameRAW
//
//  Created by Abdhi P on 23/07/23.
//

import SwiftUI

public typealias ErrorType = (state: Bool, message: String)

public struct GeneralErrorView: View {
  
  private let message: String
  private let onRetry: (() -> Void)
  
  public init(message: String, onRetry: @escaping () -> Void) {
    self.message = message
    self.onRetry = onRetry
  }
  
  public var body: some View {
    VStack(alignment: .center, spacing: 8) {
      Text(message)
        .font(.title3)
        .multilineTextAlignment(.center)
      
      if !message.contains("found") {
        Button(action: onRetry, label: {
          Text("Retry")
        })
      }
    }
    .padding()
    .frame(maxWidth: .infinity)
  }
}
