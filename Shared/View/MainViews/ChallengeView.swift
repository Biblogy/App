//
//  ChallengeView.swift
//  EBookTracking
//
//  Created by Veit Progl on 05.12.20.
//

import SwiftUI

struct ChallengeView: View {
    @State private var selected = 1
    var body: some View {
        VStack() {
            Picker("", selection: $selected) {
                        Text("Auto")
                        Text("Light")
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(width: 200)
            Text("Hello, World!")
        }
    }
}

struct ChallengeView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeView()
    }
}
