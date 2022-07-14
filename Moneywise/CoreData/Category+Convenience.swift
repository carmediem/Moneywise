//
//  Category+Convenience.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import CoreData

extension Category {
    @discardableResult convenience init(id: UUID, name: String, type: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = id
        self.name = name
        self.type = type
    }
}

enum Categories {
        case DiningOut
        case Education
        case Entertainment
        case Fitness
        case Gift
        case Grocery
        case Healthcare
        case Housing
        case Others
        case Shopping
        case Transportation
        case Utilities
        case Vacation
        case Income
        case Investment
        case Savings
}

enum ExpenseType {
    case income
    case expense
    case all
}




//    DiningOut = "fork.knife"
//     Education = "books.vertical"
//     Entertainment = "popcorn"
//     Fitness = "figure.run"
//     Gift = "gift"
//     Grocery = "cart"
//     Healthcare = "cross.vial"
//     Housing = "house"
//     Others = "face.smiling"
//     Shopping = "bag"
//     Transportation = "car"
//     Utilities
//     Vacations = "wineglass"
//     Income = "dollarsign"
//     Investment = "bitcoinsign"
//     Savings = "banknote"
