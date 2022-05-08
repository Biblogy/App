//
//  AppReducer .swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import ComposableArchitecture
import SwiftUI
import Booer_Calendar

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    calendarReducer.pullback(state: \AppState.calendar,
                             action: /AppAction.calendar,
                             environment: { _ in CalendarEnvironment() }),
  Reducer { state, action, environment in
      switch action {
      default:
          return .none
      }
  })

