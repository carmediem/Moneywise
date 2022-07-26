////
////  Practice.swift
////  Moneywise
////
////  Created by Carmen Chiu on 7/21/22.
////
//
//
///*
// Notes and Questions
// - Fetch request for categories and dates for sorting and graphs? Do I need to list out the specific categores in my model if I have them as a enum?
// 
//  let month = "July"
//  fetchRequest.predicate = NSPredicate(format: "month == %@), month)
//  
//  let category = "health"
//  fetchRequest.predicate = NSPredicate(format: "category == %@), category)
// 
// - For Entities, the entity and the class are now the same in the Data Model Inspector
// 
// - Clarify- one of the problems i had yesterday was that there were three locations/containers the  data was going and the coordinator was confused on where to access the data. We dont need to create a coordinator on its own
// 
//- using persistence controller so i dont need a data controller?
// - my managed object is my fault
// - problem with uniqueing because i was using transaction alot, i was turning fault into ibjects
// - change id to transactionID has to do with uniquing so they represent different info and the context will be committed to the right place
/*
 Fetch Request Controller
 - i need a NSFetchResultsController Delegate to one of my classes
 
 */





// */
//
// 
// 
// /
//
//import SwiftUI
//
////MARK: Fetched Results Controller
//var fetchedResultsController: NSFetchedResultsController!
// 
//func initializeFetchedResultsController() {
//    let request = NSFetchRequest(entityName: "Transaction")
//    //need at least one sort descriptor to control the data presented
//    let categorySort = NSSortDescriptor(key: "category.name", ascending: true)
//    let dateSort = NSSortDescriptor(key: "date", ascending: true)
//    let amountSort = NSSortDescriptor(key: "amount", ascending: true)
//    Will i need to list out all the options that I will want to sort by?
//    request.sortDescriptors = [categorySort, dateSort, amountSort]
//    
//    let moc = dataController.managedObjectContext
//    fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: nil, cacheName: nil)
//    //needs a delegate to notify the table view controller of changes to the underlying data structure
//    fetchedResultsController.delegate = self
//    
//    do {
//        //call to get the inital data that will be showed and also causes the ResultsController to monitor the MOC for changes
//        try fetchedResultsController.performFetch()
//    } catch {
//        fatalError("Failed to initialize FetchedResultsController: \(error)")
//    }
//}
//
//// MARK: Integrating the Fetched Results Controller with the Table View Data Source
//override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    guard let cell = tableView.dequeueReusableCell(withIdentifier: "transactionRowCell", for: indexPath) else {
//        fatalError("Wrong cell type dequeued")
//    }
//    // Set up the cell
//    guard let object = self.fetchedResultsController?.object(at: indexPath) else {
//        fatalError("Attempt to configure cell without a managed object")
//    }
//    //Populate the cell from the object
//    return cell
//}
// 
//override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//    return fetchedResultsController.sections!.count
//}
// 
//override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    guard let sections = fetchedResultsController.sections else {
//        fatalError("No sections in fetchedResultsController")
//    }
//    let sectionInfo = sections[section]
//    return sectionInfo.numberOfObjects
//}
//
////MARK: Communicating Data Changes to the Table View
////use this to communicate data changes with the tableviewcontroller for automatic updates to the assocated tableview when there are underlying chanages
//func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    tableView.beginUpdates()
//}
// 
//func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
//    switch type {
//    case .insert:
//        tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
//    case .delete:
//        tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
//    case .move:
//        break
//    case .update:
//        break
//    }
//}
// 
//func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//    switch type {
//    case .insert:
//        tableView.insertRows(at: [newIndexPath!], with: .fade)
//    case .delete:
//        tableView.deleteRows(at: [indexPath!], with: .fade)
//    case .update:
//        tableView.reloadRows(at: [indexPath!], with: .fade)
//    case .move:
//        tableView.moveRow(at: indexPath!, to: newIndexPath!)
//    }
//}
// 
//func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//    tableView.endUpdates()
//}
//
////MARK: Adding Sections
//func initializeFetchedResultsController() {
//    let request = NSFetchRequest(entityName: "Transaction")
//    let categorySort = NSSortDescriptor(key: "category.name", ascending: true)
//    let dateSort = NSSortDescriptor(key: "date", ascending: true)
//    request.sortDescriptors = [categorySort, dateSort]
//    let moc = dataController.managedObjectContext
//    //setting the same key as above because they keys need to match in order to break into multiple sections
//    fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: moc, sectionNameKeyPath: "category.name", cacheName: nil)
//    fetchedResultsController.delegate = self
//    do {
//        try fetchedResultsController.performFetch()
//    } catch {
//        fatalError("Failed to initialize FetchedResultsController: \(error)")
//    }
//}
//
//
////MARK: Implementing Custom Property-Level Validation
//
