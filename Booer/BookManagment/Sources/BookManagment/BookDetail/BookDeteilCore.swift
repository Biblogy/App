//
//  BookDetailCore.swift
//  
//
//  Created Veit Progl on 22.05.22.
//  Copyright © 2022. All rights reserved.
//

import ComposableArchitecture
import DatabaseBooer
import Foundation
public struct BookDetailCore: ReducerProtocol {
    public struct State: Equatable {
        var book: Book
        var addMode: Bool = true
        
        var progress:Float {
            get { book.progress }
            set { book.progress = newValue }
        }
        var pages:Float  {
            get { book.pageCount}
            set { book.pageCount = newValue}
        }
        
        var customSlider: CustomSliderCore.State {
            get { CustomSliderCore.State(progress: progress,
                                         pages: pages,
                                         saveEdit: { progress in
                self.updateProgress(bookProgress: BookProgress(book: self.book,
                                                                pages: Int(progress),
                                                                date: Date())
                                    )
                })
            }
            set {
                progress = newValue.progressValue
            }
        }
        
        public init(book: Book = Book(title: "")) {
            self.book = book
        }
    }

    public enum Action: Equatable {
        case onAppear
        case onPageCountChanged(Float)
        case onTitleChanged(String)
        case updateButtonTaped
        case onSubtitleChanged(String)
        case delete
        case progressChanged(Float)
        case customSlider(CustomSliderCore.Action)

    }

    public var body: some ReducerProtocol<State, Action> {
        Scope(state: \State.customSlider, action: /Action.customSlider) {
            CustomSliderCore()
        }
        
        Reduce { state, action in
            switch action {
            case let .onPageCountChanged(newText):
                state.book.pageCount = newText
                print(newText)
                return .none
            case let .onTitleChanged(newText):
                state.book.title = newText
                return .none
            case .onAppear:
                return .none
            case let .onSubtitleChanged(newText):
                state.book.subtitle = newText
                return .none
            case .updateButtonTaped:
                state.updateBook(book: state.book)
                return .none
            case .delete:
                state.deleteBook(book: state.book)
                return .none
            case .progressChanged(let progress):
                state.book.progress = progress
                return .none
            case .customSlider(_):
                return .none
            }
        }
    }
}

extension BookDetailCore.State {
    func updateBook(book: Book) {
        BiblogyDatabase.shared.books.updateBook(book: book)
    }
    
    func updateProgress(bookProgress: BookProgress) {
        let result = BiblogyDatabase.shared.books.setBookProgress(progress: bookProgress)
        switch result {
        case .failure(let err):
            print("found error: ")
            print(err.localizedDescription)
        case.success(_):
            return
        }
    }
    
    func deleteBook(book: Book) {
        BiblogyDatabase.shared.books.deleteBook(book: book)
    }
}
