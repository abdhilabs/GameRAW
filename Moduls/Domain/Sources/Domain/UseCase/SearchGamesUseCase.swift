//
//  SearchGamesUseCase.swift
//  Domain
//
//  Created by Abdhi P on 26/08/23.
//

import Combine
import Data

public protocol SearchGamesUseCase {
  func execute(query: String) -> AnyPublisher<[Game], Error>
}

open class SearchGames: SearchGamesUseCase {
  private let repository: GameRepository
  
  public init(repository: GameRepository) {
    self.repository = repository
  }
  
  public func execute(query: String) -> AnyPublisher<[Game], Error> {
    return repository.searchGames(query: query)
      .compactMap { $0.results }
      .compactMap { $0.map { $0.toGame() } }
      .eraseToAnyPublisher()
  }
}
