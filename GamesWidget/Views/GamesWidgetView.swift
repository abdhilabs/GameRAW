//
//  GamesWidgetView.swift
//  GamesWidgetExtension
//
//  Created by Abdhi P on 21/09/23.
//

import Common
import DesignSystem
import Domain
import SwiftUI
import WidgetKit

struct GamesWidgetView : View {
  var entry: SimpleEntry
  var item: Game {
    entry.item
  }
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      if entry.error != nil {
        Text(entry.error?.localizedDescription ?? "")
          .foregroundStyle(.white)
          .font(.system(size: 12))
          .multilineTextAlignment(.center)
          .fixedSize(horizontal: false, vertical: true)
          .padding(16)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else {
        VStack(alignment: .leading, spacing: 0) {
          HStack(alignment: .center, spacing: 0) {
            ForEach(item.platforms, id: \.self) { platform in
              Image(platform.iconPlatform)
                .resizable()
                .frame(width: 14, height: 14)
            }
            
            Spacer()
          }
          
          VerticalSpacer(height: 4)
          
          Text(item.title)
            .foregroundStyle(.white)
            .font(.system(size: 14))
            .multilineTextAlignment(.leading)
            .lineLimit(2)
            .bold()
            .fixedSize(horizontal: false, vertical: true)
          
          VerticalSpacer(height: 4)
          
          VStack(alignment: .leading, spacing: 4) {
            if !item.releaseDate.isEmpty {
              VStack(alignment: .leading, spacing: 2) {
                Text("games.content-row.release-date".localized)
                  .foregroundStyle(Color.General.grayLight)
                  .font(.system(size: 10))
                
                Text(item.releaseDate.stringToDate()?.string() ?? "")
                  .foregroundStyle(.white)
                  .font(.system(size: 10))
                  .multilineTextAlignment(.leading)
              }
            }
            
            if !item.genres.isEmpty {
              VStack(alignment: .leading, spacing: 2) {
                Text("games.content-row.genres".localized)
                  .foregroundStyle(Color.General.grayLight)
                  .font(.system(size: 10))
                
                Text(item.genres)
                  .foregroundStyle(.white)
                  .font(.system(size: 10))
                  .multilineTextAlignment(.leading)
                  .lineLimit(1)
              }
            }
          }
          
          Spacer()
        }
        .padding(8)
        .background(Color.Background.backgroundLight.cornerRadius(16))
        .padding(8)
      }
    }
    .background(Color.Background.background)
  }
}

struct GamesWidgetView_Previews: PreviewProvider {
  static var previews: some View {
    GamesWidgetView(entry: .init(date: Date(), item: .init(
      id: 0,
      title: "Grand Theft Auto V",
      backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
      releaseDate: "08 Aug 2022",
      platforms: ["playstation", "xbox", "pc"])))
    .previewContext(WidgetPreviewContext(family: .systemSmall))
  }
}
