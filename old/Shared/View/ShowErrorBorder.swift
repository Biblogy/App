//
//  ShowErrorBorder.swift
//  EBookTracking
//
//  Created by Veit Progl on 25.01.21.
//

import SwiftUI

struct ShowErrorBorder: ViewModifier {
    let isCorrect: Binding<Bool>
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(isCorrect.wrappedValue ? Color.secondary : Color.red, lineWidth: 1)
            )
    }
}
