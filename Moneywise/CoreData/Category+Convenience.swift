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
    @discardableResult convenience init(categoryId: UUID, name: String, type: String,  context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.init(context: context)
        self.categoryId = categoryId
        self.name = name
        self.type = type
    }
    
    enum Categories: String, CaseIterable {
        case Dining
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
        case SelectOne
        
        var CategoryImage: String {
            switch self {
            case .Dining:
               return "iconDiningOut"
            case .Education:
                return "iconEducation"
            case .Entertainment:
                return "iconEntertainment"
            case .Fitness:
                return "iconFitness"
            case .Gift:
                return  "iconGift"
            case .Grocery:
                return "iconGrocery"
            case .Healthcare:
                return "iconHealthcare"
            case .Housing:
                return "iconHousing"
            case .Others:
                return "iconOthers"
            case .Shopping:
                return "iconShopping"
            case .Transportation:
                return "iconTransportation"
            case .Utilities:
                return "iconUtilities"
            case .Vacation:
                return "iconVacation"
            case .Income:
                return  "iconIncome"
            case .Investment:
                return "iconInvestment"
            case .Savings:
                return "iconSavings"
            case .SelectOne:
                return "iconOthers"
            }
        }
  
        
        enum ExpenseType: String, CaseIterable {
            case income = "Income"
            case expense = "Expense"
            case all = "All"
            case Selection = "Select One"
            
            
            var color: Color {
                switch self {
                case .income: return .green
                case .expense: return .red
                case .Selection: return .black
                case .all:
                    return .black
                }
            }
        }
    }
}
