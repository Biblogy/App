//
//  IoC.swift
//  
//
//  Created by Veit Progl on 23.05.21.
//

import Foundation
import Relay

final class DefaultDependencyRegistry: DependencyRegistryType {

  func registerDependencies() throws {
    DependencyContainer.global.register(DeleteAlert.self) { _ in
        DeleteAlert()
    }
    /// Recursive dependencies are lazily resolved
//    DependencyContainer.global.register(MyViewControllerDataStoreType.self) { container in
//        MyViewControllerDataStore(backendService: container.resolve())
//    }
    /// etc.
  }

}
