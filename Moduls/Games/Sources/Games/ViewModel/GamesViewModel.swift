//
//  GamesViewModel.swift
//  GameRAW
//
//  Created by Abdhi P on 19/07/23.
//

import Combine
import Dependiject
import Domain
import Fortils

public protocol GamesViewModel: AnyObservableObject {
  var isGameFavorite: Published<ViewState<Bool>>.Publisher { get }
  var saveGame: Published<ViewState<Bool>>.Publisher { get }
  var deleteGame: Published<ViewState<Bool>>.Publisher { get }
  var games: Published<ViewState<[Game]>>.Publisher { get }
  var gameDetail: Published<ViewState<Game>>.Publisher { get }
  var isFullSize: Bool { get }
  
  func getGames()
  func searchGames(with query: String)
  func getDetailGame(with id: Int)
  func isGameFavorited(with id: Int)
  func saveGame(item: Game)
  func deleteGame(with id: Int)
}

public final class GamesViewModelImpl: GamesViewModel, ObservableObject {
  
  public var isGameFavorite: Published<ViewState<Bool>>.Publisher { $_isGameFavorite }
  @Published private var _isGameFavorite: ViewState<Bool> = .Initiate()
  
  public var games: Published<ViewState<[Game]>>.Publisher { $_games }
  @Published private var _games: ViewState<[Game]> = .Initiate()
  
  public var gameDetail: Published<ViewState<Game>>.Publisher { $_gameDetail }
  @Published private var _gameDetail: ViewState<Game> = .Initiate()
  
  public var saveGame: Published<ViewState<Bool>>.Publisher { $_saveGame }
  @Published private var _saveGame: ViewState<Bool> = .Initiate()
  
  public var deleteGame: Published<ViewState<Bool>>.Publisher { $_deleteGame }
  @Published private var _deleteGame: ViewState<Bool> = .Initiate()
  
  @Published public var isFullSize = false
  
  private var page = 1
  private var pageSize = 20
  private var cancellables = Set<AnyCancellable>()
  
  private let gamesUseCase: GetGamesUseCase
  private let searchGameUseCase: SearchGamesUseCase
  private let detailGameUseCase: DetailGameUseCase
  private let favoriteGameUseCase: FavoriteGameUseCase
  private let saveGameUseCase: SaveGameUseCase
  private let deleteGameUseCase: DeleteGameUseCase
  
  public init(
    gamesUseCase: GetGamesUseCase,
    searchGameUseCase: SearchGamesUseCase,
    detailGameUseCase: DetailGameUseCase,
    favoriteGameUseCase: FavoriteGameUseCase,
    saveGameUseCase: SaveGameUseCase,
    deleteGameUseCase: DeleteGameUseCase) {
      self.gamesUseCase = gamesUseCase
      self.searchGameUseCase = searchGameUseCase
      self.detailGameUseCase = detailGameUseCase
      self.favoriteGameUseCase = favoriteGameUseCase
      self.saveGameUseCase = saveGameUseCase
      self.deleteGameUseCase = deleteGameUseCase
    }
  
  public func getGames() {
    _games = .Loading()
    
    gamesUseCase.execute(page: page, pageSize: pageSize)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: break
          case .failure(let error):
            self._games = .Failed(error: error)
          }
        },
        receiveValue: { data in
          self.page += 1
          self._games = .Success(data: data)
        })
      .store(in: &cancellables)
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
  
  public func getDetailGame(with id: Int) {
    _gameDetail = .Loading()
    
    detailGameUseCase.execute(id: id)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: break
          case .failure(let error):
            self._gameDetail = .Failed(error: error)
          }
        },
        receiveValue: { data in
          self._gameDetail = .Success(data: data)
        })
      .store(in: &cancellables)
  }
  
  public func isGameFavorited(with id: Int) {
    _isGameFavorite = .Loading()
    
    favoriteGameUseCase.execute(id: id)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: break
          case .failure(let error):
            self._isGameFavorite = .Failed(error: error)
          }
        },
        receiveValue: { data in
          self._isGameFavorite = .Success(data: data)
        })
      .store(in: &cancellables)
  }
  
  public func saveGame(item: Game) {
    _saveGame = .Loading()
    
    saveGameUseCase.execute(with: item)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: break
          case .failure(let error):
            self._saveGame = .Failed(error: error)
          }
        },
        receiveValue: { data in
          self._saveGame = .Success(data: data)
        })
      .store(in: &cancellables)
  }
  
  public func deleteGame(with id: Int) {
    _deleteGame = .Loading()
    
    deleteGameUseCase.execute(id: id)
      .sink(
        receiveCompletion: { completion in
          switch completion {
          case .finished: break
          case .failure(let error):
            self._deleteGame = .Failed(error: error)
          }
        },
        receiveValue: { data in
          self._deleteGame = .Success(data: data)
        })
      .store(in: &cancellables)
  }
}
