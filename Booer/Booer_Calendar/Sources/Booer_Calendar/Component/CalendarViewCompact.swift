//
//  CalendarViewCompact.swift
//  Booer (iOS)
//
//  Created by Veit Progl on 21.04.22.
//

import SwiftUI
import ComposableArchitecture

public struct CalenderViewCompact: View {
    @State var openSheet = false
    let store: Store<CalendarState, CalendarAction>

    public init(store: Store<CalendarState, CalendarAction>){
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { viewStore in
            VStack(alignment: .leading){
                HStack(){
                    Text(viewStore.month)
                        .bold()
                    Spacer()
                    Image(systemName: "calendar")
                        .onTapGesture {
                            self.openSheet.toggle()
                        }
                }
                
                HStack() {
                    ForEach(viewStore.state.weekDays) { day in
                        VStack(){
                            HStack() {
                                Spacer()
                                Text(day.dateString)
                                    .font(.system(size: 15))
                                    .minimumScaleFactor(0.01)
                                Spacer()
                            }
                            .padding([.top, .bottom], 5)
                            .frame(minHeight: 0, maxHeight: .infinity)
                        }
                        .background(viewStore.state.activeDate == day.date ? Color.red : Color.green)
                        .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(day.isToday ? Color.blue : Color.clear , lineWidth: 4)
                            )
                        .cornerRadius(5)
                        .padding(1)
                        .onTapGesture {
                            viewStore.send(.changeActiveDate(day.date))
                        }
                        .frame(height: 35)
                    }
                }.frame(minWidth: 0, maxWidth: .infinity)
            }
            .onAppear(perform: {
                viewStore.send(.weekdays(Date()))
                viewStore.send(.getMonth(Date()))
                viewStore.send(.getMonthList)
            })
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                viewStore.send(.weekdays(Date()))
                viewStore.send(.getMonth(Date()))
                viewStore.send(.getMonthList)
            }
        }
        .sheet(isPresented: self.$openSheet, onDismiss: {}, content: {
            CalenderFullsize(store: store, isOpen: self.$openSheet)
        })
    }
}
