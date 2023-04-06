//
//  testExtension.swift
//  
//
//  Created by Veit Progl on 12.02.22.
//

#if canImport(XCTest)

import Foundation
import XCTest

extension XCTestCase {
    public func it<T>(_ description: String, block: () throws -> T) rethrows -> T {
        try XCTContext.runActivity(named: description, block: { _ in try block() })
    }
}

#endif
