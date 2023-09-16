//
//  String.swift
//  GameRAW
//
//  Created by Abdhi P on 18/07/23.
//

import Foundation

public extension String {
  func stringToDate(format: String = "yyyy-MM-dd") -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = .current
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.date(from: self)
  }
}
