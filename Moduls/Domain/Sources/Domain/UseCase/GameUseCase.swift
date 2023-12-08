//
//  GameUseCase.swift
//  Domain
//
//  Created by Abdhi P on 13/08/23.
//

import Combine
import Data

public protocol GetGamesUseCase {
  func execute(page: Int, pageSize: Int) -> AnyPublisher<[Game], Error>
}

open class GetGames: GetGamesUseCase {
  private let repository: GameRepository
  
  public init(repository: GameRepository) {
    self.repository = repository
  }
  
  public func execute(page: Int, pageSize: Int) -> AnyPublisher<[Game], Error> {
    return repository.getGamesFavorite()
      .compactMap { $0.map { Int($0.id) } }
      .flatMap { idGamesFavorite in
        self.repository.getGames(param: .init(page: page, pageSize: pageSize))
          .compactMap { $0.results }
          .compactMap { $0.map { $0.toGame(isFavorite: idGamesFavorite.contains($0.id)) } }
      }
      .eraseToAnyPublisher()
  }
}
