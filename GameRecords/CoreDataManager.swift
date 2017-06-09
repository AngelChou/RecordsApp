//
//  CoreDataManager.swift
//  GameRecords
//
//  Created by Shun-Ching, Chou on 2017/6/8.
//  Copyright © 2017年 Shun-Ching, Chou. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static func getViewContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    static func getData(entityName:String, predicate:NSPredicate?=nil) -> [NSManagedObject]{
        
        var resultsManagedObject:[NSManagedObject] = []
        
        do{
            let viewContext = getViewContext()
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            request.returnsObjectsAsFaults = false
            
            if predicate != nil {
                request.predicate = predicate
            }
            
            let results = try viewContext.fetch(request)
            resultsManagedObject = results as! [NSManagedObject]
        }
        catch{
            print("Could not get \(error)")
        }
        return resultsManagedObject
    }
    
    static func deleteData(entityName:String){
        
        let viewContext = getViewContext()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        
        do{
            let results = try viewContext.fetch(request)
            for result in results {
                viewContext.delete(result as! NSManagedObject)
            }
        }
        catch{
            print("Could not delete \(error)")
        }
    }
    }
