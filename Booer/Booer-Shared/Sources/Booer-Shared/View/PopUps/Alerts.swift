//
//  File.swift
//  
//
//  Created by Veit Progl on 24.04.21.
//

import Foundation
import CoreData

public class DeleteAlert: ObservableObject {
    public init() {}
    
    @Published public var objectName = ""
    @Published public var item: NSManagedObject?
    @Published public var show = false
    @Published public var type = ""
}
