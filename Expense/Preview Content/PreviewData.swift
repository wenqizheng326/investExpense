//
//  PreviewData.swift
//  Expense
//
//  Created by Wenqi Zheng on 11/24/23.
//

import Foundation

var transactionPreviewData = Transaction(id: 1, date: "01/24/2022", institution: "Chase", account: "Checking Chase", merchant: "Apple", amount: 1345.23, type: "credit", categoryId: 801, category: "Hardware", isPending: false, isTransfer: false, isExpense: true, isEdited: false)

var transactionListPreviewData = [Transaction](repeating: transactionPreviewData, count: 10)
