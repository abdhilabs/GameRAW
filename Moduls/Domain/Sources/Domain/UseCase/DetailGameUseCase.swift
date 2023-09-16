//
//  DetailGameUseCase.swift
//  Domain
//
//  Created by Abdhi P on 26/08/23.
//

import Combine
import Data

public protocol DetailGameUseCase {
  func execute(id: Int) -> AnyPublisher<Game, Error>
}

open class DetailGame: DetailGameUseCase {
  private let repository: GameRepository
  
  public init(repository: GameRepository) {
    self.repository = repository
  }
  
  public func execute(id: Int) -> AnyPublisher<Game, Error> {
    return repository.detailGameLocal(id: id)
      .compactMap { $0.toGame() }
      .catch({ _ in
        return self.repository.detailGameRemote(id: id)
          .compactMap { $0.toGame() }
          .eraseToAnyPublisher()
      })
      .eraseToAnyPublisher()
  }
}
