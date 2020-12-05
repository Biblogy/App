//
//  CustomAddView.swift
//  EBookTracking
//
//  Created by Veit Progl on 30.11.20.
//

import SwiftUI

struct CustomAddView: View {
    @State private var title = ""
    var body: some View {
        Form() {
            TextField("title", text: self.$title)
            TextField("Author", text: self.$title)

            TextField("Public Date", text: self.$title)
            
            TextField("Pages", text: self.$title)
        }
    }
}

struct CustomAddView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAddView()
    }
}
