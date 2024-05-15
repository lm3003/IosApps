//
//  ContentView.swift
//  WeSplit
//
//  Created by Luv Modi on 5/15/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 2
    @State private var tip = 20
    @FocusState private var amountIsFocused: Bool
    let tipValues = [0, 10, 15, 20, 25]
    
    var totalAmount: Double {
        return ((1+Double(tip)/100)*checkAmount)
    }
    
    var totalPerPerson: Double {
        return ((1+Double(tip)/100)*checkAmount)/Double(numOfPeople+2)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                Picker("Number of people", selection: $numOfPeople) {
                    ForEach(2..<100) {
                        Text("\($0) people")
                    }
                }
                
                Section("How much do you want to tip?") {
                    Picker("Tip Percentage", selection: $tip) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                }
                
                Section("Total Amount") {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("We Split")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
