//
//  CoreDataManager.swift
//  NaverMovieSearch
//
//  Created by 황제하 on 2022/06/13.
//

import UIKit
import CoreData

final class CoreDataManager {
    
    static let shared: CoreDataManager = CoreDataManager()
    private(set) lazy var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Not down cast AppDelegate")
        }
        
        return appDelegate.persistentContainer.viewContext
    }()
    
    private init() { }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        do {
            let fetchResult = try context.fetch(request)
            
            return fetchResult
        } catch {
            print(error.localizedDescription)
            
            return []
        }
    }
    
    func delete<T: NSManagedObject>(request: NSFetchRequest<T>) {
        do {
            let fetchResult = try context.fetch(request)
            
            fetchResult.forEach {
                context.delete($0)
            }
            
            saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveContext() {
        context.performAndWait {
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
