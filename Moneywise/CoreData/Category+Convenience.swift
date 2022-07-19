//
//  Category+Convenience.swift
//  Moneywise
//
//  Created by Carmen Chiu on 7/13/22.
//

import CoreData
import UIKit
import SwiftUI


extension Category {
    @discardableResult convenience init(id: UUID, name: String, type: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.id = id
        self.name = name
        self.type = type
    }

    
    enum Categories: String {
        case DiningOut = "iconDiningOut"
        case Education = "iconEducation"
        case Entertainment = "iconEntertainment"
        case Fitness = "iconFitness"
        case Gift = "iconGift"
        case Grocery = "iconGrocery"
        case Healthcare = "iconHealthcare"
        case Housing = "iconHousing"
        case Others = "iconOthers"
        case Shopping = "iconShopping"
        case Transportation = "iconTransportation"
        case Utilities = "iconUtilities"
        case Vacation = "iconVacation"
        case Income = "iconIncome"
        case Investment = "iconInvestment"
        case Savings = "iconSavings"
        
    
        enum ExpenseType: String {
            case income
            case expense
            case all
        
        
        var color: Color {
            switch self {
              case .income: return .green
              case .expense: return .red
            case .all:
                return .black
            }
}
}
    }
}
