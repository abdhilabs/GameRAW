//
//  GameRAWWebImage.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import NukeUI
import SwiftUI

public struct GameRAWWebImage: View {
  
  let urlImage: String
  var contentMode: ContentMode
  var placeholderImage: String
  
  public init(
    urlImage: String,
    contentMode: ContentMode = .fill,
    placeholderImage: String = .imgPlaceholder) {
      self.urlImage = urlImage
      self.contentMode = contentMode
      self.placeholderImage = placeholderImage
    }
  
  public var body: some View {
    LazyImage(url: URL(string: urlImage)) { state in
      if state.isLoading {
        ProgressView()
          .progressViewStyle(.circular)
      } else if let image = state.image {
        image
          .resizable()
          .aspectRatio(contentMode: contentMode)
          .scaledToFill()
      } else {
        Image(placeholderImage)
          .resizable()
          .aspectRatio(contentMode: contentMode)
          .scaledToFill()
      }
    }
  }
}
