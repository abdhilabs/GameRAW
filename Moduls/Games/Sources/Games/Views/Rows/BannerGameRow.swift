//
//  SearchGameRow.swift
//  GameRAW
//
//  Created by Abdhi P on 18/07/23.
//

import DesignSystem
import Domain
import SwiftUI

struct BannerGameRow: View {
  
  let item: Game
  
  var body: some View {
    VStack(alignment: .leading, spacing: 0) {
      GameRAWWebImage(urlImage: item.backgroundImage)
        .frame(width: UIScreen.screenWidth - 16, height: 160)
        .clipped()
      
      VStack(alignment: .leading, spacing: 0) {
        HStack(alignment: .center, spacing: 0) {
          ForEach(item.platforms, id: \.self) { platform in
            Image(platform.iconPlatform)
              .resizable()
              .frame(width: 16, height: 16)
          }
        }
        
        VerticalSpacer(height: 4)
        
        Text(item.title)
          .foregroundStyle(.white)
          .font(.system(size: 20))
          .multilineTextAlignment(.leading)
          .lineLimit(3)
          .bold()
        
        VerticalSpacer(height: 4)
        
        HStack(alignment: .top, spacing: 16) {
          if !item.releaseDate.isEmpty {
            HStack(alignment: .top, spacing: 2) {
              Text("games.content-row.release-date".localized)
                .foregroundStyle(Color.General.grayLight)
                .font(.system(size: 12))
              
              Text(item.releaseDate.stringToDate()?.string() ?? "")
                .foregroundStyle(.white)
                .font(.system(size: 12))
                .multilineTextAlignment(.leading)
            }
          }
          
          if !item.genres.isEmpty {
            HStack(alignment: .top, spacing: 2) {
              Text("games.content-row.genres".localized)
                .foregroundStyle(Color.General.grayLight)
                .font(.system(size: 12))
              
              Text(item.genres)
                .foregroundStyle(.white)
                .font(.system(size: 12))
                .multilineTextAlignment(.leading)
            }
          }
        }
      }
      .padding(.horizontal, 12)
      .padding(.vertical, 16)
    }
    .cornerRadius(12)
    .frame(width: UIScreen.screenWidth - 16)
    .background(Color.Background.backgroundLight.cornerRadius(12))
  }
}

struct BannerGameRow_Previews: PreviewProvider {
  static var previews: some View {
    BannerGameRow(
      item: .init(
        id: 0, title: "Grand Theft Auto V",
        backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
        genres: "Shooter",
        platforms: ["playstation", "xbox", "pc"])
    )
  }
}
