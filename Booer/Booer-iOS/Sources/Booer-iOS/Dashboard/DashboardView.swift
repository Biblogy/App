//
//  DashboardView.swift
//  
//
//  Created by Veit Progl on 06.03.22.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView(){
            List(){
                Section(){
                    CalenderViewCompact()
                }
                
                Section(){
                    Text("")
                }
            }.navigationTitle("Dashboard")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
