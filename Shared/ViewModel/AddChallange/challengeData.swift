//
//  challengeData.swift
//  EBookTracking
//
//  Created by Veit Progl on 03.03.21.
//

import Foundation
import Combine
import SwiftUI

public class challengeData: ObservableObject {
    @Published var bookID: String = "-404"
    @Published var bookTitle: String
    @Published var book: Book?
    
    init(bookTitle: String) {
        self.bookTitle = bookTitle
    }
}
