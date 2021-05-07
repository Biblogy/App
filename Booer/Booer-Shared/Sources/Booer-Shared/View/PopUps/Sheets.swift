//
//  File.swift
//  
//
//  Created by Veit Progl on 24.04.21.
//

import Foundation
public enum addSheets {
    case AddBook
    case AddChallenge
}

public class AddSheetData: ObservableObject {
    public init() {}
    
    @Published public var selectedSheet = addSheets.AddBook
    @Published public var isOpen = false
}

