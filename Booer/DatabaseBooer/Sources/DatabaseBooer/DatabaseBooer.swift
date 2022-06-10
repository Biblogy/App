import CoreData
public struct DatabaseBooer: Equatable {
    var viewContext = PersistenceController.shared.container.viewContext

    public init() {
        getCoreDataLocation()
    }
    
    public init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        getCoreDataLocation()
    }
    
    public func saveBook(book: Book) {
        let newBook = BooksDB(context: viewContext)
        newBook.id = UUID().uuidString
        newBook.title = book.title
        newBook.pages = Int16(book.pageCount ?? 0)
        newBook.subtitle = book.subtitle
        newBook.coverSmall = book.cover?.smallThumbnail
        newBook.coverThumbnail = book.cover?.thumbnail
        
        do {
            try viewContext.save()
        } catch {
            print("error")
        }
    }
    
    public func getAllBooks() -> [Book] {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "BooksDB")

        var books: [Book] = []
        do {
            let objects = try viewContext.fetch(fetch)
            for es in objects {
                if let object = es as? BooksDB {
                    books.append(Book(from: object))
                }
            }
        } catch {
            print("error")
        }
        return books
    }
    
    func getCoreDataLocation(){
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print(urls[urls.count-1] as URL)
    }
    
}
