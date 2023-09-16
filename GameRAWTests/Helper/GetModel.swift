//
//  GetModel.swift
//  GameRAWTests
//
//  Created by Abdhi P on 03/09/23.
//

import Foundation
import ObjectMapper

class GetModel<T: Mappable> {
  
  func loadFile(with name: String? = nil) -> T? {
    let bundle = Bundle(for: GetModel.self)
    
    let fileName: String
    if let name = name {
      fileName = name
    } else {
      fileName = String(describing: T.self)
    }
    
    guard let path = bundle.path(forResource: fileName, ofType: "json"),
          let value = try? String(contentsOfFile: path) else {
      return nil
    }
    
    return T(JSONString: value)
  }
}
