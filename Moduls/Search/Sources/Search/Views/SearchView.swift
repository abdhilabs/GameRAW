//
//  SearchView.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import Common
import DesignSystem
import Dependiject
import Domain
import SwiftUI

public struct SearchView: View {
  
  @EnvironmentObject private var navigation: NavigationStateManager
  
  @Store var viewModel = Factory.shared.resolve(SearchViewModel.self)
  
  @StateObject private var textObserver = TextFieldObserver()
  
  @State private var isLoading = false
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
        TextField(text: $textObserver.searchValue) {
          Text("search.placeholder.search-games".localized)
        }
        .textFieldStyle(.roundedBorder)
        
        if !games.isEmpty {
          Text("search.content.found-games-%lld".localizedPlural(games.count))
            .font(.system(size: 14))
            .padding(.horizontal, 8)
        }
      }
      .padding([.top, .horizontal], 16)
      
      if textObserver.searchValue.isEmpty && games.isEmpty {
        Text("search.message.find-games".localized)
          .multilineTextAlignment(.center)
          .frame(maxWidth: .infinity)
          .padding()
      } else if error.state {
        GeneralErrorView(message: error.message.localized) {
          searchGame(query: textObserver.debouncedValue)
        }
      } else {
        ScrollView(showsIndicators: false) {
          LazyVGrid(columns: columns, spacing: 16) {
            ForEach(games, id: \.id) { item in
              Button(action: {
                navigation.navigate(to: .detailGame(id: item.id))
              }, label: {
                GamesRow(item: item)
              })
            }
          }
          .padding(.horizontal, 8)
          
          if isLoading {
            HStack {
              Spacer()
              ProgressView()
                .progressViewStyle(.circular)
              Spacer()
            }
          }
        }
      }
      
      Spacer()
    }
    .background(Color.Background.background)
    .onReceive(textObserver.$debouncedValue) { value in
      searchGame(query: value)
    }
    .viewState(
      viewModel.games,
      onLoading: { state in
        isLoading = state
      },
      onSuccess: { data in
        if data.isEmpty {
          self.error = (true, "search.message.did-not-find-games")
        } else {
          games = data
        }
      },
      onFailed: { error in
        self.error = (true, error.localizedDescription)
        print("Error: \(error.localizedDescription)")
      }
    )
  }
  
  private func searchGame(query: String) {
    error = (false, "")
    games.removeAll()
    if !query.isEmpty {
      viewModel.searchGames(with: query)
    }
  }
}

struct SearchView_Previews: PreviewProvider {
  static var previews: some View {
    SearchView()
  }
}
