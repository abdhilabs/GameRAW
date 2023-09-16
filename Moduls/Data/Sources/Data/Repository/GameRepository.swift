//
//  GameRepository.swift
//  Data
//
//  Created by Abdhi P on 13/08/23.
//

import Combine

public protocol GameRepository {
  func getGames(param: GameRequest) -> Future<GameDataResponse, Error>
  func getGamesFavorite() -> Future<[GameEntity], Error>
  func searchGames(query: String) -> Future<GameDataResponse, Error>
  func detailGameLocal(id: Int) -> Future<GameEntity, Error>
  func detailGameRemote(id: Int) -> Future<GameResponse, Error>
  func isGameFavorite(with id: Int) -> Future<Bool, Error>
  func saveGame(item: GameEntityRequest) -> Future<Bool, Error>
  func deleteGame(with id: Int) -> Future<Bool, Error>
}

public struct GameRepositoryImpl: GameRepository {
  fileprivate let remoteDataSource: GameRemoteDataSource
  fileprivate let localDataSource: GameLocalDataSource
  
  public init(remoteDataSource: GameRemoteDataSource, localDataSource: GameLocalDataSource) {
    self.remoteDataSource = remoteDataSource
    self.localDataSource = localDataSource
  }
  
  public func getGames(param: GameRequest) -> Future<GameDataResponse, Error> {
    return remoteDataSource.getGames(param: param)
  }
  
  public func getGamesFavorite() -> Future<[GameEntity], Error> {
    return localDataSource.getGames()
  }
  
  public func searchGames(query: String) -> Future<GameDataResponse, Error> {
    return remoteDataSource.searchGames(query: query)
  }
  
  public func detailGameLocal(id: Int) -> Future<GameEntity, Error> {
    return localDataSource.getGame(with: id)
  }
  
  public func detailGameRemote(id: Int) -> Future<GameResponse, Error> {
    return remoteDataSource.detailGame(id: id)
  }
  
  public func isGameFavorite(with id: Int) -> Future<Bool, Error> {
    return localDataSource.isGameFavorite(with: id)
  }
  
  public func saveGame(item: GameEntityRequest) -> Future<Bool, Error> {
    return localDataSource.saveGame(item: item)
  }
  
  public func deleteGame(with id: Int) -> Future<Bool, Error> {
    return localDataSource.deleteGame(with: id)
  }
}
