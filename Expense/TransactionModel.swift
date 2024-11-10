//
//  TransactionModel.swift
//  Expense
//
//  Created by Wenqi Zheng on 11/24/23.
//

import Foundation
import SwiftUI

struct Transaction: Identifiable, Decodable, Hashable{
    let id: Int
    let date: String
    let institution: String
    let account: String
    let merchant: String
    let amount: Double
    let type: TransactionType.RawValue
    var categoryId: Int
    var category: String
    var isPending: Bool
    var isTransfer: Bool
    var isExpense: Bool
    var isEdited: Bool
    
    var icon: Image{
        if let category = Category.all.first(where: {$0.id == categoryId}){
            return category.icon
        }
        return Image(systemName: "questionmark.circle")
    }
    
    var dateParse: Date{
        date.dateParsed()
    }
    
    var signedAmount: Double{
        return type == TransactionType.credit.rawValue ? amount: -amount
    }
    
    var month: String{
        dateParse.formatted(.dateTime.year().month(.wide))
    }
}

enum TransactionType: String{
    case debit = "debit"
    case credit = "credit"
    case cash = "cash"
}

struct Category{
    let id: Int
    let name: String
    let icon: Image
    //var mainCategoryId: Int?
}

extension Category{
    static let publicTransport = Category(id: 101, name: "Public Transportation", icon: Image(systemName: "bus"))
    static let taxi = Category(id: 102, name: "Taxi / Uber", icon: Image(systemName: "car" ))
    static let mobilePhone = Category(id: 201, name: "Mobile Phone", icon: Image(systemName: "iphone"))
    static let movies = Category(id: 301, name: "Movies", icon: Image(systemName: "popcorn"))
    static let bankFee = Category(id: 401, name: "Bank Fee", icon: Image(systemName: "banknote"))
    static let financeCharge = Category(id: 402, name: "Finance Charge", icon: Image(systemName: "dollarsign"))
    static let groceries = Category(id: 501, name: "Groceries", icon: Image(systemName: "carrot"))
    static let restaurants = Category(id: 502, name: "Restaurants", icon: Image(systemName: "fork.knife"))
    static let rent = Category(id: 601, name: "Rent", icon: Image(systemName: "house"))
    static let homeSupplies = Category(id: 602, name: "Household Supplies", icon: Image(systemName: "lightbulb"))
    static let paycheck = Category(id: 701, name: "Paycheck", icon: Image(systemName: "signature"))
    static let software = Category(id: 702, name: "Software", icon: Image(systemName: "app.badge"))
    static let creditCardPayment = Category(id: 901, name: "Credit Card Payment", icon: Image(systemName: "creditcard"))
}

extension Category{
    static let categories: [Category] = [
        .publicTransport,
        .taxi,
        .mobilePhone,
        .movies,
        .bankFee,
        .financeCharge,
        .groceries,
        .restaurants,
        .rent,
        .homeSupplies,
        .paycheck,
        .software,
        .creditCardPayment
    ]
    
    static let all: [Category] = categories
}
