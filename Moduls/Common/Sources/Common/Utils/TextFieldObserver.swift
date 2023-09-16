//
//  TextFieldObserver.swift
//  GameRAW
//
//  Created by Abdhi P on 03/09/23.
//

import Combine
import Foundation

public class TextFieldObserver: ObservableObject {
  @Published public var debouncedValue = ""
  @Published public var searchValue = ""
  
  private var cancellables = Set<AnyCancellable>()
  
  public init() {
    $searchValue
      .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
      .sink(receiveValue: { [weak self] value in
        self?.debouncedValue = value
      })
      .store(in: &cancellables)
  }
}
