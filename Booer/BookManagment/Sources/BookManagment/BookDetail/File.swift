//
//  File.swift
//  
//
//  Created by Veit Progl on 22.08.22.
//

import Foundation
import ComposableArchitecture
import Foundation
import SwiftUI

public struct Todo: Equatable, Identifiable {
  public var description = ""
  public let id: UUID
  public var isComplete = false
    
    public init(description: String = "", id: UUID = UUID(), isComplete: Bool = false) {
        self.description = description
        self.id = id
        self.isComplete = isComplete
    }
}

public enum TodoAction: Equatable {
  case checkBoxToggled
  case textFieldChanged(String)
}

public struct TodoEnvironment {}

public let todoReducer = Reducer<Todo, TodoAction, TodoEnvironment> { todo, action, _ in
  switch action {
  case .checkBoxToggled:
    todo.isComplete.toggle()
    return .none

  case let .textFieldChanged(description):
    todo.description = description
    return .none
  }
}

struct TodoView: View {
  let store: Store<Todo, TodoAction>

  var body: some View {
    WithViewStore(self.store) { viewStore in
      HStack {
        Button(action: { viewStore.send(.checkBoxToggled) }) {
          Image(systemName: viewStore.isComplete ? "checkmark.square" : "square")
        }
        .buttonStyle(.plain)

        TextField(
          "Untitled Todo",
          text: viewStore.binding(get: \.description, send: TodoAction.textFieldChanged)
        )
      }
      .foregroundColor(viewStore.isComplete ? .gray : nil)
    }
  }
}
