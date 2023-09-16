//
//  String.swift
//  DesignSystem
//
//  Created by Abdhi P on 09/09/23.
//

import Foundation

public extension String {
  var localized: String {
    BundleToken.bundle.localizedString(forKey: self, value: nil, table: nil)
  }
  
  func localizedPlural(_ value: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: self, value: nil, table: "Localizable")
    return String(format: format, locale: Locale.current, arguments: value)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
#if SWIFT_PACKAGE
    return Bundle.module
#else
    return Bundle(for: BundleToken.self)
#endif
  }()
}
