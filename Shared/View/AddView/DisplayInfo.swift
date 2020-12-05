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

func DisplayInformation(book: Doc) -> some View {
    return VStack(alignment: .leading) {
        Text(book.title).font(.headline)
        Text("Author:")
        
        ForEach(Array(Set(book.authorName)), id: \.self) { name in
            Text(name)
        }
        
        Text("Date:")
        
        ForEach(Array(Set(arrayLiteral: String("\(book.publishYear)"))), id: \.self) { date in
            Text(date)
        }
        Spacer()
    }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
}
