//
//  ContentView.swift
//  WeSplit2
//
//  Created by Ricardo on 07/07/23.
//

import SwiftUI

struct ContentView: View {
    
    // Define state variables for user inputs and calculations
    @State private var checkAmount = 80.0 // State for the check amount
    @State private var numberOfPeople = 2  // State for the number of people
    @State private var tipPercentage = 20  // State for the tip percentage
    @FocusState private var amountIsFocused: Bool // State for focusing on the amount input

    // Pre-defined tip percentages
    let tipPercentages = [10, 15, 20, 25]

    // Define the currency format based on the current locale
    let currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")

    // Computed property to calculate total per person
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    // Computed property to calculate grand total
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    

    var body: some View {
        NavigationView {
            Form {
                Section {
                    // Input field for check amount
                    HStack {
                        Text("🧾")
                        TextField("Amount", value: $checkAmount, format: currency)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    }

                    // Picker to select number of people
                    Picker("👥 People", selection: $numberOfPeople) {
                        ForEach(2..<99) {
                            Text("\($0) people")
                        }
                    }
                    
                    // Stepper and Picker for tip percentage
                    Stepper("🛎 Tip: \(tipPercentage)%", value: $tipPercentage)
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(8)
                } header: {
                    Text("Bill")
                }
                
                // Section to display the results
                Section {
                    HStack {
                        Text("👤 Per Person:").bold()
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                    HStack {
                        Text("💰 Total:").bold()
                        Text(grandTotal, format: currency)
                    }
                } header: {
                    Text("Results")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                // Toolbar for Done button on the keyboard
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
