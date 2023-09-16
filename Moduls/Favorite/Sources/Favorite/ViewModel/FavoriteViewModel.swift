//
//  FavoriteViewModel.swift
//  GameRAW
//
//  Created by Abdhi P on 02/08/23.
//

import Dependiject
import Domain
import CoreData
import Combine
import Fortils

public protocol FavoriteViewModel: AnyObservableObject {
  var games: Published<ViewState<[Game]>>.Publisher { get }
  
  func getFavoriteGames()
}

public class FavoriteViewModelImpl: FavoriteViewModel, ObservableObject {
  
  public var games: Published<ViewState<[Game]>>.Publisher { $_games }
  @Published private var _games: ViewState<[Game]> = .Initiate()
  
  private var cancellables = Set<AnyCancellable>()
  
  private let gameFavoriteUseCase: GamesFavoriteUseCase
  
  public init(gameFavoriteUseCase: GamesFavoriteUseCase) {
    self.gameFavoriteUseCase = gameFavoriteUseCase
  }
  
  public func getFavoriteGames() {
    _games = .Loading()
    
    gameFavoriteUseCase.execute()
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: break
          case .failure(let error):
            self._games = .Failed(error: error)
          }
        },
        receiveValue: { data in
          self._games = .Success(data: data)
        })
      .store(in: &cancellables)
  }
}
