//
//  Date.swift
//  GameRAW
//
//  Created by Abdhi P on 23/07/23.
//

import Foundation

public extension Date {
  func string(format: String = "MMM d, YYYY") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.locale = .current
    return dateFormatter.string(from: self) 
  }
}
