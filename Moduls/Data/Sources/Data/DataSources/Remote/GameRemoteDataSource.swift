//
//  GameRemoteDataSource.swift
//  Data
//
//  Created by Abdhi P on 13/08/23.
//

import Combine

public protocol GameRemoteDataSource {
  func getGames(param: GameRequest) -> Future<GameDataResponse, Error>
  func searchGames(query: String) -> Future<GameDataResponse, Error>
  func detailGame(id: Int) -> Future<GameResponse, Error>
}

public struct GameRemoteDataSourceImpl: GameRemoteDataSource {
  public init() { }
  
  public func getGames(param: GameRequest) -> Future<GameDataResponse, Error> {
    return NetworkService.shared.connect(api: .games(param: param), mappableType: GameDataResponse.self)
  }
  
  public func searchGames(query: String) -> Future<GameDataResponse, Error> {
    return NetworkService.shared.connect(api: .searchGames(query: query), mappableType: GameDataResponse.self)
  }
  
  public func detailGame(id: Int) -> Future<GameResponse, Error> {
    return NetworkService.shared.connect(api: .gameDetail(id: id), mappableType: GameResponse.self)
  }
}
