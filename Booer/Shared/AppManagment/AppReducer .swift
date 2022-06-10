//
//  AppReducer .swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import ComposableArchitecture
import SwiftUI
import BooerCalendar
import BookManagment

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    calendarReducer.pullback(state: \.calendar,
                             action: /AppAction.calendar,
                             environment: { _ in CalendarEnvironment() }),
    AddBookCore.reducer.pullback(state: \.addBookState,
                                    action: /AppAction.addBook,
                                 environment: { _ in AddBookCore.Environment.dev }),
  Reducer { state, action, environment in
      switch action {
      default:
          return .none
      }
  })

