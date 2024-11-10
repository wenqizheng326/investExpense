//
//  Transactions.swift
//  Expense Profolio
//
//  Created by Wenqi Zheng on 11/9/24.
//

import SwiftUI
import Charts

struct Transactions: View {
    @State var transactions:[String] = []
    @State private var stackPath: [String] = []
    @State private var isInputTransPresented: Bool = false
    
    var sampleData:[TransactionData] = [
        .init(type: "Cube", count: 50),
        .init(type: "Sphere", count: 20),
        .init(type: "Pyramid", count: 40)
    ]
    

    var body: some View {
        
        NavigationStack(path: $stackPath){
            Text("Spendings")
                .font(.title2)
                .padding()
                .frame(maxWidth:.infinity, alignment: .center)
            if #available(iOS 17.0, *) {
                Chart(sampleData){ element in
                    SectorMark(
                        angle: .value("Count", element.count),
                        innerRadius: .ratio(0.63),
                        angularInset: 1.5
                    )
                    
                }
                .chartBackground{ chartProxy in
                    GeometryReader{ geometry in
                        let frame = geometry[chartProxy.plotAreaFrame]
                        VStack{
                            Text("2024 \nTotal Spendings")
                                .font(.callout)
                                .foregroundColor(.secondary)
                                .padding(.bottom,5)
                            Text("$1000")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        .position(x: frame.midX, y: frame.midY)
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.65,
                       height: UIScreen.main.bounds.width * 0.65)
                .padding(.bottom,30)
            } else {
                VStack {
                        Text("2024 \nTotal Spendings")
                            .font(.callout)
                            .foregroundColor(.secondary)
                            .padding()
                        Text("$1000")
                            .font(.title2)
                            .foregroundColor(.primary)
                        
                       
                        ZStack {
                            Circle()
                                .trim(from: 0, to: 0.75)
                                .stroke(Color.blue, lineWidth: 20)
                                .rotationEffect(.degrees(-90))
                            Circle()
                                .trim(from: 0.75, to: 1)
                                .stroke(Color.green, lineWidth: 20)
                                .rotationEffect(.degrees(-90))
                        }
                        .frame(width: 150, height: 150)
                        .padding()
                        
                        Text("Breakdown by Type")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                .padding(.bottom,30)
            }
            
            ZStack{
                VStack(spacing: 0){
                    Text("Monthly Breakdown")
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 20)
                        .padding(.bottom,-30)
                    List{
                        HStack{
                            Text("January")
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text("$100")
                                .font(.body)
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    .scrollContentBackground(.hidden)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing){
                            Text("Clear All")
                        }
                    }
                    Spacer()
                }
                .padding(.top,30)
                .padding(.bottom,90)
                Spacer()
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action: {
                            isInputTransPresented = true
                        }) {
                            
                            Circle()
                                .fill(Color(.blue))
                                .frame(width: 70, height: 70, alignment: .trailing)
                                .shadow(radius: 15)
                                .overlay{
                                    Image(systemName: "plus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 30))
                                        .bold()
                                }
                                .padding(.trailing,50)
                                .padding(.bottom,30)
                        }
                        
                    }
                    .padding(.top,20)
                }
            }
            
        }
        .sheet(isPresented: $isInputTransPresented) {
                    TransactionEntryView()
        }
    }
    
}

    
struct TransactionEntryView: View {
    @State private var transactionType: String = ""
    @State private var amount: String = ""
    @State private var categor: String = ""
    @State private var date: Date = Date()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Transaction Details")) {
                    TextField("Transaction Type", text: $transactionType)
                    
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                }
                Button("Save") {
                    // Add action to save the transaction details
                }
            }
            .navigationTitle("New Transaction")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    Transactions()
}

