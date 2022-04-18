//
//  ContentView.swift
//  Shared
//
//  Created by Veit Progl on 18.04.22.
//

import SwiftUI
import Inject

struct ContentView: View {
    @ObservedObject private var iO = Inject.observer
    
    var body: some View {
        Text("Hello, world!")
            .padding()
            .enableInjection()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
