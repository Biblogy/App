//
//  DisplayInfo.swift
//  EBookTracking
//
//  Created by Veit Progl on 01.12.20.
//

import SwiftUI
import Alamofire
import CoreData
import Combine

func DisplayInformation(book: BookItem) -> some View {
    return VStack(alignment: .leading) {
        Text(book.title ?? "Error").font(.headline)
        Text("Author:")
        
        ForEach(Array(Set(book.authorName ?? ["Error"])).sorted(), id: \.self) { name in
            Text(name)
        }
        
        Text("Date:")
        
        ForEach(Array(Set(arrayLiteral: String("\(book.publishYear)"))).sorted(), id: \.self) { date in
            Text(date)
        }
        Spacer()
    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
}
