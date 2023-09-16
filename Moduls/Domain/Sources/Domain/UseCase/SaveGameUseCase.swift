//
//  SaveGameUseCase.swift
//  Domain
//
//  Created by Abdhi P on 02/09/23.
//

import Combine
import Data

public protocol SaveGameUseCase {
  func execute(with item: Game) -> AnyPublisher<Bool, Error>
}

open class SaveGame: SaveGameUseCase {
  private let repository: GameRepository
  
  public init(repository: GameRepository) {
    self.repository = repository
  }
  
  public func execute(with item: Game) -> AnyPublisher<Bool, Error> {
    return repository.saveGame(item: item.toGameEntityRequest())
      .eraseToAnyPublisher()
  }
}
