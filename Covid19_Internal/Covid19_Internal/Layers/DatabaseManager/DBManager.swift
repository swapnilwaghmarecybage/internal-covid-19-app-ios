//
//  DBManager.swift
//  Covid19_Internal
//
//  Created by Swapnil Waghm on 9/9/20.
//  Copyright © 2020 Cybage. All rights reserved.
//

import Foundation
import CoreData
import UIKit

struct DBManager {
    
   static func save(id: String?) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate, let _id = id else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "DeletedNews",
                                       in: managedContext)!
        let newsid = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        newsid.setValue(_id, forKeyPath: "id")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    static func fetchIds() -> [String]?{
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "DeletedNews")
        
        //3
        var objects = [NSManagedObject]()
        var ids = [String]()
        do {
           objects  = try managedContext.fetch(fetchRequest)
            ids = objects.compactMap({($0.value(forKey: "id") as? String )})
            return ids
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}
