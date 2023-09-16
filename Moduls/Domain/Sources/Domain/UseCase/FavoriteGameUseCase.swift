//
//  FavoriteGameUseCase.swift
//  Domain
//
//  Created by Abdhi P on 02/09/23.
//

import Combine
import Data

public protocol FavoriteGameUseCase {
  func execute(id: Int) -> AnyPublisher<Bool, Error>
}

open class FavoriteGame: FavoriteGameUseCase {
  private let repository: GameRepository
  
  public init(repository: GameRepository) {
    self.repository = repository
  }
  
  public func execute(id: Int) -> AnyPublisher<Bool, Error> {
    return repository.isGameFavorite(with: id)
      .eraseToAnyPublisher()
  }
}
