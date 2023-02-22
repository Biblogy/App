//
//  File.swift
//  
//
//  Created by Veit Progl on 21.02.23.
//

import Foundation
import XCTest

extension XCTestCase {
    func it<T>(_ description: String, block: () throws -> T) rethrows -> T {
        try XCTContext.runActivity(named: description, block: { _ in try block() })
    }
}
