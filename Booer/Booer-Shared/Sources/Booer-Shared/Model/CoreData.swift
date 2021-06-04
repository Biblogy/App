//
//  File.swift
//  
//
//  Created by Veit Progl on 03.06.21.
//

import Foundation

public enum BookProgressState: String {
    case progress = "Progress"
    case done = "Done"
    case notStarted = "Not Started"
}

extension Book {
    var state: BookProgressState {
        get {
            return BookProgressState(rawValue: self.stateValue ?? "Not Started")!
        }
        set{
            self.stateValue = newValue.rawValue
        }
    }
}
