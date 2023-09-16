//
//  FavoriteRow.swift
//  GameRAW
//
//  Created by Abdhi P on 06/08/23.
//

import DesignSystem
import Domain
import SwiftUI

struct FavoriteRow: View {
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
        
        if !item.releaseDate.isEmpty {
          VerticalSpacer(height: 4)
          
          let releaseDate = item.releaseDate.stringToDate()?.string() ?? ""
          Text("favorite.content-row.release-%@".localizedPlural(releaseDate))
            .foregroundStyle(.white)
            .font(.system(size: 12))
            .multilineTextAlignment(.leading)
        }
        
        VerticalSpacer(height: 4)
        
        let rating = "\(item.rating.clean)/\(item.ratingTop)"
        Text("favorite.content-row.rating-%@".localizedPlural(rating))
          .foregroundStyle(.white)
          .font(.system(size: 12))
          .multilineTextAlignment(.leading)
        
        Spacer()
      }
      .padding(.horizontal, 12)
      .padding(.top, 16)
      .padding(.bottom, 8)
    }
    .cornerRadius(12)
    .frame(width: UIScreen.screenWidth / 2 - 16)
    .background(Color.Background.backgroundLight.cornerRadius(12))
  }
}

struct FavoriteRow_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteRow(
      item: .init(
        id: 0,
        title: "Grand Theft Auto V",
        backgroundImage: "https://media.rawg.io/media/games/456/456dea5e1c7e3cd07060c14e96612001.jpg",
        releaseDate: "08 Aug 2022",
        platforms: ["playstation", "xbox", "pc"])
    )
    .previewLayout(.sizeThatFits)
  }
}
