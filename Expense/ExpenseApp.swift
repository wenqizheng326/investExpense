//
//  ExpenseApp.swift
//  Expense
//
//  Created by Wenqi Zheng on 11/24/23.
//

import SwiftUI

@main
struct ExpenseApp: App {
    @StateObject var transactionListVM = TransactionListViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}


