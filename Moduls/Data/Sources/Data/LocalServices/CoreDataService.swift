//
//  CoreDataController.swift
//  GameRAW
//
//  Created by Abdhi P on 31/07/23.
//

import CoreData
import Combine

final class CoreDataService {
  static let shared = CoreDataService()
  
  private static var persistentContainer: NSPersistentContainer = {
    let moduleBundle = Bundle.module
    let modelURL = moduleBundle.url(forResource: "GameRAW", withExtension: "momd")!
    let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) ?? NSManagedObjectModel()
        
    let container = NSPersistentContainer(name: "GameRAW", managedObjectModel: managedObjectModel)
    container.loadPersistentStores { _, error in
      if let error = error {
        print("Core Data failed to load: \(error.localizedDescription)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
  }()
  
  var context: NSManagedObjectContext {
    return Self.persistentContainer.viewContext
  }
  
  func getGameDetail(with id: Int) -> Future<GameEntity, Error> {
    let fetchRequest = GameEntity.fetchRequest()
    fetchRequest.predicate = NSPredicate(
      format: "id == %@", "\(id)"
    )
    
    return Future { promise in
      if let game = try? self.context.fetch(fetchRequest).first {
        promise(.success(game))
      } else {
        promise(.failure(ApiError.noData))
      }
    }
  }
  
  func isGameFavorited(with id: Int) -> Future<Bool, Error> {
    let fetchRequest: NSFetchRequest<GameEntity>
    fetchRequest = GameEntity.fetchRequest()
    
    fetchRequest.predicate = NSPredicate(
      format: "id == %@", "\(id)"
    )
    
    return Future { promise in
      if let favoriteGames = try? self.context.fetch(fetchRequest) {
        promise(.success(!favoriteGames.isEmpty))
      }
    }
  }
  
  func saveGame(item: GameEntityRequest) -> Future<Bool, Error> {
    let entity = GameEntity(context: context)
    entity.id = Int64(item.id)
    entity.title = item.title
    entity.backgroundImage = item.backgroundImage
    entity.releaseDate = item.releaseDate
    entity.genres = item.genres
    entity.playtime = Int16(item.playtime)
    entity.rating = item.rating
    entity.ratingTop = Int16(item.ratingTop)
    entity.descriptionRaw = item.description

    let platformEntities: [PlatformsEntity] = item.platforms.map({
      let platform = PlatformsEntity(context: context)
      platform.name = $0
      return platform
    })
    entity.platforms = NSSet(array: platformEntities)
    
    let ratingEntities: [SubDetailGameEntity] = item.ratings.map({
      let rating = SubDetailGameEntity(context: context)
      rating.id = Int16($0.id)
      rating.title = $0.title
      rating.subtitle = $0.subtitle
      rating.iconColor = $0.iconColor
      return rating
    })
    entity.ratings = NSSet(array: ratingEntities)
    
    let subDetailEntities: [SubDetailGameEntity] = item.subDetails.map({
      let subDetail = SubDetailGameEntity(context: context)
      subDetail.id = Int16($0.id)
      subDetail.title = $0.title
      subDetail.subtitle = $0.subtitle
      subDetail.iconColor = $0.iconColor
      return subDetail
    })
    entity.subDetails = NSSet(array: subDetailEntities)
    
    return Future { promise in
      do {
        try self.context.save()
        promise(.success(true))
      } catch {
        promise(.failure(error))
      }
    }
  }
  
  func deleteGame(with id: Int) -> Future<Bool, Error> {
    let fetchRequest: NSFetchRequest<GameEntity>
    fetchRequest = GameEntity.fetchRequest()
    
    fetchRequest.predicate = NSPredicate(
      format: "id == %@", "\(id)"
    )
    
    fetchRequest.includesPropertyValues = false
    
    if let objects = try? context.fetch(fetchRequest) {
      for object in objects {
        context.delete(object)
      }
    }
    
    return Future { promise in
      do {
        try self.context.save()
        promise(.success(true))
      } catch {
        promise(.failure(error))
      }
    }
  }
  
  func favoriteGames() -> Future<[GameEntity], Error> {
    let fetchRequest: NSFetchRequest<GameEntity>
    fetchRequest = GameEntity.fetchRequest()
    
    return Future { promise in
      do {
        let games = try self.context.fetch(fetchRequest)
        promise(.success(games))
      } catch {
        promise(.failure(error))
      }
    }
  }
}
