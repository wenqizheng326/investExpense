//
//  TransactionListViewModel.swift
//  Expense
//
//  Created by Wenqi Zheng on 11/24/23.
//

import Foundation
import Combine
import Collections

typealias TransactionGroup = OrderedDictionary<String, [Transaction]>
typealias TransactionPrefixSum  = [(String,Double)]

final class TransactionListViewModel: ObservableObject{
    @Published var transactions: [Transaction] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init(){
        getTransactions()
    }
    
    func getTransactions(){
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else{
            print("invalid RUL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap{ (data,response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else{
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case.failure(let error):
                    print("Error fetching transactions:", error.localizedDescription)
                case.finished:
                    print("Finished fetching transactions")
                }
            } receiveValue: { [weak self] result in
                self?.transactions = result
                //dump(self?.transactions)
            }
            .store(in: &cancellables)

    }
    func groupTransactionByMonth() -> TransactionGroup{
        guard !transactions.isEmpty else {return [:]}
        
        let groupedTransactions = TransactionGroup(grouping: transactions){$0.month}
        return groupedTransactions
    }
    func accumulateTransactions() -> TransactionPrefixSum{
        print("accumulatTransactions")
        guard !transactions.isEmpty else {return [] }
        
        let today = "02/17/2022".dateParsed() //Data()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        
        print("dateinterval",dateInterval)
        var sum: Double = .zero
        var cumulativeSum = TransactionPrefixSum()
        
        for date in stride(from: dateInterval.start,to: today, by: 60*50*24){
            
        }
        return dateInterval
    }
}
