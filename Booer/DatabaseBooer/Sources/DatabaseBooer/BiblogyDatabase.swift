import CoreData
public struct BiblogyDatabase {
    var viewContext = PersistenceController.shared.container.viewContext
    public static let shared = BiblogyDatabase()
    
    @Injected(\.bookDatabase) public var books: BookDatabaseProtrocol
    
    public init() {
        getCoreDataLocation()
    }
    
    public init(viewContext: NSManagedObjectContext) {
        self.viewContext = viewContext
        getCoreDataLocation()
    }
    
    func getCoreDataLocation(){
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print(urls[urls.count-1] as URL)
    }
    
}
