//
//  WidgetFavoriteViewModel.swift
//  FavoriteWidgetExtension
//
//  Created by Abdhi P on 18/09/23.
//

import Dependiject
import Domain
import Combine
import Fortils

public protocol WidgetGamesViewModel: AnyObservableObject {
  func getFavoriteGames(onComplete: @escaping ([Game], Error?) -> Void)
}

public class WidgetGamesViewModelImpl: WidgetGamesViewModel, ObservableObject {
  private var cancellables = Set<AnyCancellable>()
  
  private let gamesUseCase: GetGamesUseCase
  
  public init(gamesUseCase: GetGamesUseCase) {
    self.gamesUseCase = gamesUseCase
  }
  
  public func getFavoriteGames(onComplete: @escaping ([Game], Error?) -> Void) {
    gamesUseCase.execute(page: 1, pageSize: 1000)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: break
          case .failure(let error):
            onComplete([], error)
          }
        },
        receiveValue: { data in
          onComplete(data.shuffled(), nil)
        })
      .store(in: &cancellables)
  }
}
