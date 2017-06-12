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
    
    // MARK: - Common Functions
    
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
    
    // MARK: - Customized Functions: Users
    static func isLoginSuccess(username: String, password: String) -> Bool {
        
        let users = getData(entityName: "Users", predicate: NSPredicate(format: "username==%@ && password==%@", username, password)) as! [Users]
        
        for user in users {
            print(user.username ?? "no username")
            print(user.password ?? "no password")
        }
        
        if users.count == 1 {
            print("we got match user!")
            return true
        }
        
        return false
    }
    
    static func createNewUser(username: String, password: String) -> Bool{
        
        let viewContext = getViewContext()
        let newAccount = NSEntityDescription.insertNewObject(forEntityName: "Users", into: viewContext) as! Users
        
        newAccount.username = username
        newAccount.password = password
        // TODO: change default value to false
        newAccount.emailVerified = true
        
        do{
            try viewContext.save()
        }
        catch{
            print("Could not save \(error)")
            return false
        }
        
        print("Create new user success.")
        return true
    }
    
    static func isEmailExist(_ email: String) -> Bool {
        let users = getData(entityName: "Users", predicate: NSPredicate(format: "username == %@", email)) as! [Users]
        if users.count > 0{
            print(users.count)
            for user in users {
                
                print(user.username!)
                print(user.password!)
            }
            
            print("This username has been registered!")
            return true
        }
        
        print("No duplicate user found")
        return false

    }
    
    static func isEmailVerified(_ email: String) -> Bool {
        let users = getData(entityName: "Users", predicate: NSPredicate(format: "username == %@", email)) as! [Users]
        if users.count > 0{
            print(users.count)
            for user in users {
                
                print(user.username!)
                print(user.password!)
                
                if user.emailVerified {
                    print("This email has been verified!")
                    return true
                }
            }
            
            print("This email has not been verified!")
            return false
        }
        
        print("This email is not found")
        return false
    }
    
    
    
    
}
