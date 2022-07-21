////
////  CoreDataStack.swift
////  Moneywise
////
////  Created by Carmen Chiu on 7/13/22.
////
//
//import Foundation
//import CoreData
//
//enum CoreDataStack {
//    static let container: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "Moneywise")
//        container.loadPersistentStores { (_, error) in
//            if let error = error {
//                fatalError("Error loading persistent stores: \(error)")
//            }
//        }
//        return container
//    }()
//
//    static var context: NSManagedObjectContext { container.viewContext }
//    static func saveContext() {
//        if context.hasChanges {
//            do {
//                try context.save()
//            } catch {
//                print("Error saving context: \(error)")
//            }
//        }
//    }
//}
