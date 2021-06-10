//
//  File.swift
//  
//
//  Created by Veit Progl on 07.05.21.
//

import Foundation
import SwiftUI
import Combine
import CoreData
import AppKit
import CoreGraphics

public class AddBookData: ObservableObject {
    public init () {}
    
    @Published public var title = ""
    @Published public var progress: Float = 0
    @Published public var author = ""
    @Published public var isbn = "000"
    @Published public var baugtAt = Date()
    @Published public var id = UUID().uuidString
    #if os(iOS)
    @Published public var image: UIImage?
    #else
    @Published public var image: NSImage?
    
    func pngDataFrom(image:NSImage) -> Data {
        let cgImage = image.cgImage(forProposedRect: nil, context: nil, hints: nil)!
        let bitmapRep = NSBitmapImageRep(cgImage: cgImage)
        let jpegData = bitmapRep.representation(using: NSBitmapImageRep.FileType.png, properties: [:])!
        return jpegData
    }
    
    func nsImageFrom(data: Data) -> NSImage {
        return NSImage(data: data)!
    }
    #endif
    
    @Published public var state: BookProgressState = .bookshelf
    @Published public var pages = "" {
        didSet {
            let filtered = pages.filter { $0.isNumber }
            
            if pages != filtered {
                pages = filtered
            }
        }
    }
    
    public func saveToDB(context: NSManagedObjectContext) -> Bool {
        if self.title != "" && self.pages != "" {
            let newItem = Book(context: context)
            newItem.title = self.title
            newItem.progress = self.progress
            newItem.author = self.author
            newItem.isbn = self.isbn
            #if os(iOS)
            #else
            newItem.cover = pngDataFrom(image: image!)
            #endif
            newItem.year = self.baugtAt
            newItem.state = .bookshelf
            newItem.id = self.id
            newItem.pages = Float(self.pages) ?? 0
            newItem.state = state

            do {
                try context.save()
                return true
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        } else {
//            isCorrect = false
            return false
        }
    }
}
