//
//  CustomSliderView.swift
//  
//
//  Created Veit Progl on 26.02.23.
//  Copyright © 2023. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct CustomSliderView: View {
    internal let store: Store<CustomSliderCore.State, CustomSliderCore.Action>

    public init(store: Store<CustomSliderCore.State, CustomSliderCore.Action>) {
        self.store = store
    }
    
    @State var showSheet = false
    
    let formatter: NumberFormatter = {
       let formatter = NumberFormatter()
       formatter.numberStyle = .decimal
       return formatter
    }()

    public var body: some View {
        WithViewStore(store) { viewStore in
            HStack {
                VStack() {
                    HStack() {
                        Text("0")
                        Spacer()
                        Text("\(Int(viewStore.pages))")
                    }.padding([.bottom], -5)
                    Slider(value: viewStore.binding(get: \.progressValue,
                                                    send: CustomSliderCore.Action.progressChanged),
                           in: 0...viewStore.pages,
                           step: 1)
                    GeometryReader { geometry in
                        HStack() {
                            Text("\(Int(viewStore.progressValue))")
                                .position(x: CGFloat(viewStore.progressValue) * geometry.size.width / CGFloat(viewStore.pages))
                                .frame(alignment: .center)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 100)
                        }
                    }.padding([.leading, .trailing], 12)
                }
                .padding([.top], 10)
                .padding([.bottom], -3)
                           
                Button(action: {
//                    viewStore.send(.toggleEditSheet(true))
                    showSheet.toggle()
                }) {
                    Image(systemName: "pencil")
                        .imageScale(.large)
                }
            }
            .sheet(isPresented: $showSheet, content: {
                TextField("Page Numbers",
                          value: viewStore.binding(get: \.progressValue, send: CustomSliderCore.Action.progressChanged),
                          formatter: NumberFormatter())
            })
        }
    }
}

struct CustomSliderView_Preview: PreviewProvider {
    static var previews: some View {
        CustomSliderView(
            store:  Store(initialState: CustomSliderCore.State(progress: 2, pages: 10), reducer: CustomSliderCore())
        )
    }
}
