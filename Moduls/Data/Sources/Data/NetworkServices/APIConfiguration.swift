//
//  APIConfiguration.swift
//  GameRAW
//
//  Created by Abdhi P on 17/07/23.
//

import Foundation

struct APIConfiguration {
  static let baseUrl = "https://api.rawg.io/api"
  static let apiKey = Bundle.main.object(forInfoDictionaryKey: "APIKey") as? String ?? ""
}
