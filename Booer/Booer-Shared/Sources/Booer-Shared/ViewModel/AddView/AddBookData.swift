//
//  File.swift
//  
//
//  Created by Veit Progl on 07.05.21.
//

import Foundation
import SwiftUI
import Combine

public class AddBookData: ObservableObject {
    public init () {}
    
    @Published public var title = ""
    @Published public var progress: Float = 0
    @Published public var author = ""
    @Published public var isbn = "000"
    @Published public var baugtAt = Date()
    @Published public var id = UUID().uuidString
    @Published public var pages: Decimal?
}
