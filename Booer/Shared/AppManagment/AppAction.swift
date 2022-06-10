//
//  AppAction.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import Foundation
import ComposableArchitecture
import BooerCalendar
import BookManagment

enum AppAction: Equatable {
    case calendar(CalendarAction)
    case addBook(AddBookCore.Action)
    case bookOverview(BookOverviewCore.Action)
}
