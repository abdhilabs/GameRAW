//
//  GamesView.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import Common
import DesignSystem
import Dependiject
import Domain
import SwiftUI

public struct GamesView: View {
  
  @EnvironmentObject private var navigation: NavigationStateManager
  
  @Store private var viewModel = Factory.shared.resolve(GamesViewModel.self)
  
  @State private var isLoading = false
  @State private var error: ErrorType = (false, "")
  @State private var games: [Game] = []
  
  private let columns = [
    GridItem(.flexible(), spacing: 8),
    GridItem(.flexible(), spacing: 8)
  ]
  
  public init() {}
  
  public var body: some View {
    VStack(alignment: .leading, spacing: 16) {
      VStack(alignment: .leading) {
        Text("games.header.title".localized)
          .font(.largeTitle)
          .bold()
        
        Text("games.header.subtitle".localized)
          .font(.system(size: 14))
      }
      .padding([.top, .horizontal], 16)
            
      ScrollView(showsIndicators: false) {
        LazyVStack(alignment: .center, spacing: 16) {
          ForEach(games, id: \.id) { item in
            Button(action: {
              navigation.navigate(to: .detailGame(id: item.id))
            }, label: {
              BannerGameRow(item: item)
            })
          }
                    
          if error.state {
            GeneralErrorView(message: error.message) {
              getGames()
            }
          } else if !viewModel.isFullSize {
            ProgressView()
              .progressViewStyle(.circular)
              .onAppear {
                getGames()
              }
          }
        }
        .padding(.horizontal, 8)
      }
      .padding(.bottom, 8)
      
      Spacer()
    }
    .background(Color.Background.background)
    .viewState(
      viewModel.games,
      onLoading: { state in
        isLoading = state
      },
      onSuccess: { data in
        games.append(contentsOf: data)
      },
      onFailed: { error in
        self.error = (true, error.localizedDescription)
      }
    )
  }
  
  private func getGames() {
    error = (false, "")
    viewModel.getGames()
  }
}

struct GamesView_Previews: PreviewProvider {
  static var previews: some View {
    GamesView()
  }
}
