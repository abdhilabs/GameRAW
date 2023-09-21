//
//  GamesWidgetBundle.swift
//  GamesWidget
//
//  Created by Abdhi P on 21/09/23.
//

import Data
import Dependiject
import Domain
import SwiftUI
import WidgetKit

@main
struct GamesWidgetBundle: WidgetBundle {
  
  init() {
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
      
      Service(.transient, GetGamesUseCase.self) { resolver in
        GetGames(repository: resolver.resolve())
      }
      
      Service(.weak, WidgetGamesViewModel.self) { resolver in
        WidgetGamesViewModelImpl(gamesUseCase: resolver.resolve())
      }
    }
  }
  
  var body: some Widget {
    GamesWidget()
  }
}
