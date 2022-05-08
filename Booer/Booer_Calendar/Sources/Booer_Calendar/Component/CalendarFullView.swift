//
//  CalendarFullView.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 22.04.22.
//

import Foundation
import SwiftUI
import ComposableArchitecture

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

public struct CalendarView<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    let store: Store<CalendarState, CalendarAction>

    let showHeaders: Bool
    let content: (CalendarDate) -> DateView
    let month: CalendarMonth

    public init(
        store: Store<CalendarState, CalendarAction>,
        month: CalendarMonth,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (CalendarDate) -> DateView
    ) {
        self.store = store
        self.showHeaders = showHeaders
        self.content = content
        self.month = month
    }

    public var body: some View {
        WithViewStore(store) { viewStore in
            LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
                Section(header: header(for: month.date)) {
                    ForEach(month.days) { date in
                        if calendar.isDate(date.date, equalTo: month.date, toGranularity: .month) {
                            content(date).id(date.date)
                        } else {
                            content(date).hidden()
                        }
                    }
                }
            }
        }
    }

    private func header(for month: Date) -> some View {
        let component = calendar.component(.month, from: month)
        let formatter = component == 1 ? DateFormatter.monthAndYear : .month

        return Group {
            if showHeaders {
                Text(formatter.string(from: month))
                    .font(.title)
                    .padding()
            }
        }
    }
}

public struct CalenderFullsize: View {
    @Binding var isOpen: Bool
    let store: Store<CalendarState, CalendarAction>

    public init(store: Store<CalendarState, CalendarAction>, isOpen:Binding<Bool>){
        self.store = store
        self._isOpen = isOpen
    }
    
    public var body: some View {
        WithViewStore(store) { viewStore in
            NavigationView(){
                ScrollViewReader { proxy in
                    ScrollView(){
                        VStack() {
                            ForEach(viewStore.state.monthList){ month in
                                VStack {
                                    CalendarView(store: store, month: month) { day in
                                        Text(day.dateString)
                                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 28)
                                            .padding(8)
                                            .background(Color.blue)
                                            .cornerRadius(8)
                                            .overlay(
                                                    RoundedRectangle(cornerRadius: 5)
                                                        .stroke(day.isToday ? Color.green : Color.clear, lineWidth: 4)
                                                )
                                            .onTapGesture {
                                                viewStore.send(.changeActiveDate(day.date))
                                                isOpen = false
                                            }
                                    }.padding()
                                }.id(month.date.getMonthString())
                            }
                        }
                        .onAppear(perform: {
                            withAnimation {
                                proxy.scrollTo(viewStore.state.activeDate.getMonthString(), anchor: .top)
                            }
                        })
                    }
                }
                .navigationTitle("Calendar")
                .navigationBarItems(trailing: VStack{
                    Button("close") {
                        isOpen = false
                    }
                })
            }
        }
    }
}
