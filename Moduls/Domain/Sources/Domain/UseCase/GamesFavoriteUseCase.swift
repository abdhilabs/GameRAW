//
//  GamesFavoriteUseCase.swift
//  Domain
//
//  Created by Abdhi P on 03/09/23.
//

import Combine
import Data

public protocol GamesFavoriteUseCase {
  func execute() -> AnyPublisher<[Game], Error>
}

open class GamesFavorite: GamesFavoriteUseCase {
  private let repository: GameRepository
  
  public init(repository: GameRepository) {
    self.repository = repository
  }
  
  public func execute() -> AnyPublisher<[Game], Error> {
    return repository.getGamesFavorite()
      .compactMap { $0.map { $0.toGame() } }
      .eraseToAnyPublisher()
  }
}
