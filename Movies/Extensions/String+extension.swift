//
//  LocalizedStringKey+extension.swift
//  Movies
//
//  Created by Tarek Radovan on 13/09/2025.
//

import SwiftUI

extension String {
  
  var localized: LocalizedStringKey {
    LocalizedStringKey(self)
  }
}
