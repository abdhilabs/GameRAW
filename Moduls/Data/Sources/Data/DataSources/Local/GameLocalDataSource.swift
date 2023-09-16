//
//  GameLocalDataSource.swift
//  Data
//
//  Created by Abdhi P on 31/08/23.
//

import Combine

public protocol GameLocalDataSource {
  func getGames() -> Future<[GameEntity], Error>
  func getGame(with id: Int) -> Future<GameEntity, Error>
  func isGameFavorite(with id: Int) -> Future<Bool, Error>
  func saveGame(item: GameEntityRequest) -> Future<Bool, Error>
  func deleteGame(with id: Int) -> Future<Bool, Error>
}

public struct GameLocalDataSourceImpl: GameLocalDataSource {
  public init() { }
  
  public func getGames() -> Future<[GameEntity], Error> {
    return CoreDataService.shared.favoriteGames()
  }
  
  public func getGame(with id: Int) -> Future<GameEntity, Error> {
    return CoreDataService.shared.getGameDetail(with: id)
  }
  
  public func isGameFavorite(with id: Int) -> Future<Bool, Error> {
    return CoreDataService.shared.isGameFavorited(with: id)
  }
  
  public func saveGame(item: GameEntityRequest) -> Future<Bool, Error> {
    return CoreDataService.shared.saveGame(item: item)
  }
  
  public func deleteGame(with id: Int) -> Future<Bool, Error> {
    return CoreDataService.shared.deleteGame(with: id)
  }
}
