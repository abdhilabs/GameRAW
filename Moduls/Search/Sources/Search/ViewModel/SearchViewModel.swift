//
//  SearchViewModel.swift
//  Search
//
//  Created by Abdhi P on 08/09/23.
//

import Combine
import Dependiject
import Domain
import Fortils

public protocol SearchViewModel: AnyObservableObject {
  var games: Published<ViewState<[Game]>>.Publisher { get }
  
  func searchGames(with query: String)
}

public final class SearchViewModelImpl: SearchViewModel, ObservableObject {
  public var games: Published<ViewState<[Game]>>.Publisher { $_games }
  @Published private var _games: ViewState<[Game]> = .Initiate()
  
  var page = 1
  var pageSize = 20
  @Published var isFullSize = false
  
  private var cancellables = Set<AnyCancellable>()
  
  private let searchGameUseCase: SearchGamesUseCase
  
  public init(searchGameUseCase: SearchGamesUseCase) {
    self.searchGameUseCase = searchGameUseCase
  }
  
  public func searchGames(with query: String) {
    _games = .Loading()
    
    searchGameUseCase.execute(query: query)
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
