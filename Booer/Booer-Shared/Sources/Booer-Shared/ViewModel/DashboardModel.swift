//
//  File.swift
//  
//
//  Created by Veit Progl on 30.05.21.
//

import Foundation
import CoreData
import SwiftUI
import Combine

protocol DashboardModelProtocol {
    func calcStreak() -> Int
}

public class DashboardModel: DashboardModelProtocol, ObservableObject {
    var items: FetchedResults<ReadProgress>
    public init(items: FetchedResults<ReadProgress>) {
        self.items = items
    }
    
    public var streak = 0
    public func calcStreak() -> Int {
        var index = 0
        streak = 0
        let dates = Array(Set(items.map({$0.date?.removeTime()})))
        
        for item in dates {
            if item?.getDay() == Date().getDay() {
                streak += 1
                index += 1
                while item?.getDay() == Calendar.current.date(byAdding: .day, value: -index, to: Date())?.getDay() {
                    streak += 1
                    index += 1
                }
            } else {
                streak = 0
            }
        }
        return streak
    }
}
