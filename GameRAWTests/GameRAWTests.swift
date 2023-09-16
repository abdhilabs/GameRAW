//
//  GameRAWTests.swift
//  GameRAWTests
//
//  Created by Abdhi P on 17/07/23.
//

import Combine
import Dependiject
import Data
import Domain
import XCTest
@testable import GameRAW

final class GameRAWTests: XCTestCase {
  
  private var gameUseCase: GetGamesUseCase!
  private var searchGameUseCase: SearchGamesUseCase!
  private var detailGameUseCase: DetailGameUseCase!
  private var cancellables: Set<AnyCancellable>!
  
  override func setUp() {
    super.setUp()
    cancellables = []
    
    Factory.register {
      Service(.transient, GameRemoteDataSource.self) { _ in
        GameRemoteDataSourceStub()
      }
      
      Service(.transient, GameLocalDataSource.self) { _ in
        GameLocalDataSourceImpl()
      }
      
      Service(.transient, GameRepository.self) { resolver in
        GameRepositoryImpl(remoteDataSource: resolver.resolve(), localDataSource: resolver.resolve())
      }
    }
    
    gameUseCase = GetGames(repository: Factory.shared.resolve())
    searchGameUseCase = SearchGames(repository: Factory.shared.resolve())
    detailGameUseCase = DetailGame(repository: Factory.shared.resolve())
  }
  
  func testGetGames() throws {
    let games = try awaitPublisher(gameUseCase.execute(page: 0, pageSize: 20))
    XCTAssertEqual(games.count, 20)
  }
  
  func testSearchGames() throws {
    let games = try awaitPublisher(searchGameUseCase.execute(query: "red dead redemption"))
    XCTAssertEqual(games.count, 20)
  }
  
  func testGetDetailGame() throws {
    let game = try awaitPublisher(detailGameUseCase.execute(id: 28))
    XCTAssertEqual(game.title, "Red Dead Redemption 2")
  }
}

struct GameRemoteDataSourceStub: GameRemoteDataSource {
  func getGames(param: GameRequest) -> Future<GameDataResponse, Error> {
    return Future { promise in
      let responseFile = "GamesSuccess"
      guard let response: GameDataResponse = GetModel().loadFile(with: responseFile) else {
        promise(.failure(ApiError.failedMappingError))
        return
      }
      
      if response.results == nil {
        promise(.failure(ApiError.noData))
      } else {
        promise(.success(response))
      }
    }
  }
  
  func searchGames(query: String) -> Future<GameDataResponse, Error> {
    return Future { promise in
      let responseFile = "SearchGamesSuccess"
      guard let response: GameDataResponse = GetModel().loadFile(with: responseFile) else {
        promise(.failure(ApiError.failedMappingError))
        return
      }
      
      if response.results == nil {
        promise(.failure(ApiError.noData))
      } else {
        promise(.success(response))
      }
    }
  }
  
  func detailGame(id: Int) -> Future<GameResponse, Error> {
    return Future { promise in
      let responseFile = "DetailGameSuccess"
      guard let response: GameResponse = GetModel().loadFile(with: responseFile) else {
        promise(.failure(ApiError.failedMappingError))
        return
      }
      
      if response.id == nil {
        promise(.failure(ApiError.noData))
      } else {
        promise(.success(response))
      }
    }
  }
}
