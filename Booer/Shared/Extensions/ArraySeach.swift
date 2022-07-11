//
//  ArraySeach.swift
//  Booer
//
//  Created by Veit Progl on 14.06.22.
//

import Foundation
import CasePaths

@available(iOS 16.0, *)
extension Array where Element == AppCore.Route {
  func find<Value>(_ casePath: CasePath<Element, Value>) -> Value? {
    compactMap { element in
      guard let value = casePath.extract(from: element) else { return nil }
      return value
    }.first
  }
  mutating func update<Value>(_ casePath: CasePath<Element, Value>, with value: Value)
  where Value: Equatable {
    guard
      let routeIndex = firstIndex(where: { element in
        guard casePath.extract(from: element) != .none else { return false }
        return true
      })
    else {
      return
    }
    self[routeIndex] = casePath.embed(value)
  }
}
