//
//  NetworkService.swift
//  Data
//
//  Created by Abdhi P on 12/08/23.
//

import Combine
import Foundation
import ObjectMapper
import Moya

final class NetworkService {
  static let shared = NetworkService()
  
  private var cancellables = Set<AnyCancellable>()
  
  func connect<T: Mappable>(api: GameAPI, mappableType: T.Type) -> Future<T, Error> {
    return Future { promise in
      let provider = MoyaProvider<GameAPI>()
      provider.request(api) { result in
        switch result {
        case .success(let response):
          do {
            guard let jsonResponse = try response.mapJSON() as? [String: Any] else {
              promise(.failure(ApiError.invalidJSONError))
              return
            }
            
            if response.statusCode != 200 {
              let message = jsonResponse["message"] as? String ?? "Server error with http code: \(response.statusCode)"
              promise(.failure(ApiError.middlewareError(code: response.statusCode, message: message)))
              return
            }
            
            let map = Map(mappingType: .fromJSON, JSON: jsonResponse)
            guard let responseObject = mappableType.init(map: map) else {
              promise(.failure(ApiError.failedMappingError))
              return
            }
            promise(.success(responseObject))
          } catch {
            promise(.failure(ApiError.invalidJSONError))
          }
        case .failure:
          promise(.failure(ApiError.connectionError))
        }
      }
    }
  }
}
