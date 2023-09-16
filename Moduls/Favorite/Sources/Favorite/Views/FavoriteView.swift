//
//  FavoriteView.swift
//  GameRAW
//
//  Created by Abdhi P on 01/08/23.
//

import Common
import DesignSystem
import Dependiject
import Domain
import SwiftUI

public struct FavoriteView: View {
  
  @EnvironmentObject private var navigation: NavigationStateManager
  
  @Store private var viewModel = Factory.shared.resolve(FavoriteViewModel.self)
  
  @State private var error: ErrorType = (false, "")
  @State private var games: [Game] = []
  
  private let columns = [
    GridItem(.flexible(), spacing: 8),
    GridItem(.flexible(), spacing: 8)
  ]
  
  public init() {}
  
  public var body: some View {
    VStack(alignment: .leading) {
      VStack(alignment: .leading) {
        Text("favorite.header.title".localized)
          .font(.largeTitle)
          .bold()
        
        Text("favorite.header.subtitle".localized)
          .font(.system(size: 14))
      }
      .padding([.top, .horizontal], 16)
      
      if games.isEmpty {
        Text("favorite.message.dont-have-favorite-games".localized)
          .multilineTextAlignment(.center)
          .frame(maxWidth: .infinity)
          .padding()
      } else {
        ScrollView(showsIndicators: false) {
          LazyVGrid(columns: columns, spacing: 16) {
            ForEach(games, id: \.id) { item in
              Button(action: {
                navigation.navigate(to: .detailGame(id: Int(item.id)))
              }, label: {
                FavoriteRow(item: item)
              })
            }
          }
          .padding(.horizontal, 8)
        }
      }
      
      Spacer()
    }
    .onAppear {
      viewModel.getFavoriteGames()
    }
    .background(Color.Background.background)
    .viewState(
      viewModel.games,
      onSuccess: { data in
        games = data
      },
      onFailed: { error in
        self.error = (true, error.localizedDescription)
        print("Error: \(error.localizedDescription)")
      }
    )
  }
}

struct FavoriteView_Previews: PreviewProvider {
  static var previews: some View {
    FavoriteView()
  }
}
