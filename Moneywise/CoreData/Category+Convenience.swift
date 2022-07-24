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

    
    //    enum TransactionCategories: String {
    //        case DiningOut
    //        case Education
    //        case Entertainment
    //        case Fitness
    //        case Gift
    //        case Grocery
    //        case Healthcare
    //        case Housing
    //        case Others
    //        case Shopping
    //        case Transportation
    //        case Utilities
    //        case Vacation
    //        case Income
    //        case Investment
    //        case Savings
    
    
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
//        extension Category {
//            static let Dining = Category(id: 1, name: "Dining", image: "iconDiningOut")
//            static let Education = Category(id: 2, name: "Education",image: "iconEducation")
//            static let Entertainment = Category(id: 3, name: "Entertainment", image: "iconEntertainment")
//            static let Fitness = Category(id: 4, name: "Fitness", image = "iconFitness")
//            static let Gifts = Category(id: 5, name: "Gifts",  image = "iconGift")
//            static let Grocery = Category(id: 1, name: "Grocery", image = "iconGrocery"
//            static let Healthcare = Category(id: 6, name: "Healthcare", image = "iconHealthcare")
//            static let Housing = Category(id: 7, name: "Housing", image= "iconHousing")
//            static let Others = Category(id: 8, name: "Others", image = "iconOthers")
//            static let Shopping = Category(id: 9, name: "Shopping", image = "iconShopping")
//            static let Transportation = Category(id: 11, name: "Transportation", image = "iconTransportation"
//            static let Utilities = Category(id: 12, name: "Utilities", image = "iconUtilities")
//            static let Vacations = Category(id: 13, name: "Vacations", image = "iconVacation"")
//            static let Income = Category(id: 14, name: "Income", image = "iconIncome")
//            static let Investmensts = Category(id: 15, name: "Investments", image = "iconInvestment"
//            static let Savings = Category(id: 16, name: "Savings", image = "iconSavings")
//        }
//
        
        
        
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
