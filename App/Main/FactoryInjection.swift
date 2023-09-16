//
//  File.swift
//  GameRAW
//
//  Created by Abdhi P on 03/09/23.
//

import Dependiject
import Data
import Domain
import Games
import Favorite
import Search
import SwiftUI
import netfox

final class FactoryInjection {
  static var shared = FactoryInjection()
  
  func inject() {
    Factory.register {
      Service(.transient, GameRemoteDataSource.self) { _ in
        GameRemoteDataSourceImpl()
      }
      
      Service(.transient, GameLocalDataSource.self) { _ in
        GameLocalDataSourceImpl()
      }
      
      Service(.transient, GameRepository.self) { resolver in
        GameRepositoryImpl(remoteDataSource: resolver.resolve(), localDataSource: resolver.resolve())
      }
      
      Service(.transient, DeleteGameUseCase.self) { resolver in
        DeleteGame(repository: resolver.resolve())
      }
      
      Service(.transient, FavoriteGameUseCase.self) { resolver in
        FavoriteGame(repository: resolver.resolve())
      }
      
      Service(.transient, SaveGameUseCase.self) { resolver in
        SaveGame(repository: resolver.resolve())
      }
      
      Service(.transient, GetGamesUseCase.self) { resolver in
        GetGames(repository: resolver.resolve())
      }
      
      Service(.transient, SearchGamesUseCase.self) { resolver in
        SearchGames(repository: resolver.resolve())
      }
      
      Service(.transient, DetailGameUseCase.self) { resolver in
        DetailGame(repository: resolver.resolve())
      }
      
      Service(.transient, GamesFavoriteUseCase.self) { resolver in
        GamesFavorite(repository: resolver.resolve())
      }
      
      Service(.weak, GamesViewModel.self) { resolver in
        GamesViewModelImpl(
          gamesUseCase: resolver.resolve(),
          searchGameUseCase: resolver.resolve(),
          detailGameUseCase: resolver.resolve(),
          favoriteGameUseCase: resolver.resolve(),
          saveGameUseCase: resolver.resolve(),
          deleteGameUseCase: resolver.resolve())
      }
      
      Service(.weak, SearchViewModel.self) { resolver in
        SearchViewModelImpl(searchGameUseCase: resolver.resolve())
      }
      
      Service(.weak, FavoriteViewModel.self) { resolver in
        FavoriteViewModelImpl(gameFavoriteUseCase: resolver.resolve())
      }
    }
  }
}
