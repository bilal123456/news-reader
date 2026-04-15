import UIKit
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    var context: NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate)
            .persistentContainer
            .viewContext
    }
    
    // MARK: - Save
    func saveArticle(article: Article) {
        let entity = NSEntityDescription.insertNewObject(
            forEntityName: "BookmarkArticle",
            into: context
        )
        
        entity.setValue(article.id, forKey: "id")
        entity.setValue(article.title, forKey: "title")
        entity.setValue(article.byline, forKey: "byline")
        entity.setValue(article.publishedDate, forKey: "publishedDate")
        entity.setValue(article.abstract, forKey: "abstract")
        entity.setValue(article.imageURL, forKey: "imageURL")
        
        saveContext()
    }
    
    // MARK: - Fetch
    func fetchArticles() -> [NSManagedObject] {
        let request = NSFetchRequest<NSManagedObject>(entityName: "BookmarkArticle")
        
        do {
            return try context.fetch(request)
        } catch {
            print("Fetch error:", error)
            return []
        }
    }
    
    // MARK: - Delete
    func deleteArticle(id: Int) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BookmarkArticle")
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        
        do {
            let results = try context.fetch(request)
            for object in results {
                context.delete(object as! NSManagedObject)
            }
            saveContext()
        } catch {
            print("Delete error:", error)
        }
    }
    
    // MARK: - Check Exists
    func isBookmarked(id: Int) -> Bool {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BookmarkArticle")
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        
        do {
            let count = try context.count(for: request)
            return count > 0
        } catch {
            return false
        }
    }
    
    // MARK: - Save Context
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Save error:", error)
        }
    }
}
