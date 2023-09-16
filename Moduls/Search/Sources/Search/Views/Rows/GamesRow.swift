//
//  GamesRow.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import Common
import DesignSystem
import Domain
import SwiftUI

struct GamesRow: View {
  
  let item: Game
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      GameRAWWebImage(urlImage: item.backgroundImage, contentMode: .fit)
        .frame(width: UIScreen.screenWidth / 2 - 16, height: 150)
        .clipped()
      
      VStack(alignment: .leading, spacing: 0) {
        if !item.platforms.isEmpty {
          HStack(alignment: .center, spacing: 0) {
            ForEach(item.platforms, id: \.self) { platform in
              Image(platform.iconPlatform)
                .resizable()
                .frame(width: 16, height: 16)
            }
          }
          
          VerticalSpacer(height: 12)
        }
        
        Text(item.title)
          .foregroundStyle(.white)
          .font(.system(size: 20))
          .multilineTextAlignment(.leading)
          .lineLimit(3)
          .bold()
        
        if !item.genres.isEmpty {
          VerticalSpacer(height: 4)
          
          Text(item.genres)
            .foregroundStyle(.white)
            .font(.system(size: 12))
            .multilineTextAlignment(.leading)
        }
        
        Spacer()
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 16)
    }
    .cornerRadius(12)
    .frame(width: UIScreen.screenWidth / 2 - 16)
    .background(Color.Background.backgroundLight.cornerRadius(12))
  }
}

struct GamesRow_Previews: PreviewProvider {
  static var previews: some View {
    GamesRow(
      item: .init(
        id: 0,
        title: "Grand Theft Auto V",
        backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
        genres: "Shooter",
        platforms: ["playstation", "xbox", "pc"])
    )
  }
}
