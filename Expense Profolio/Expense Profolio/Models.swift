//
//  Models.swift
//  Expense Profolio
//
//  Created by Wenqi Zheng on 11/9/24.
//
import Foundation

struct TransactionData: Identifiable {
    var id = UUID()
    var type: String
    var count: Double
}


