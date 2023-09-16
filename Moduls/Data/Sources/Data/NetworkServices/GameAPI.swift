//
//  GameAPI.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import Foundation
import Moya

enum GameAPI {
  case games(param: GameRequest)
  case searchGames(query: String)
  case gameDetail(id: Int)
}

extension GameAPI: TargetType {
  var baseURL: URL {
    return URL(string: APIConfiguration.baseUrl)!
  }
  
  var path: String {
    switch self {
    case .games, .searchGames:
      return "/games"
    case .gameDetail(let id):
      return "/games/\(id)"
    }
  }
  
  var task: Moya.Task {
    switch self {
    case .games(let param):
      return .requestParameters(parameters: param.toJSON(), encoding: URLEncoding.queryString)
    case .searchGames(let query):
      return .requestParameters(parameters: ["search": query, "key": APIConfiguration.apiKey], encoding: URLEncoding.queryString)
    case .gameDetail:
      return .requestParameters(parameters: ["key": APIConfiguration.apiKey], encoding: URLEncoding.queryString)
    }
  }
  
  var method: Moya.Method { .get }
  var headers: [String : String]? { nil }
}
