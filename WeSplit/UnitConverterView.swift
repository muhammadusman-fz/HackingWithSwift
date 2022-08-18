//
//  UnitConverterView.swift
//  WeSplit-Project-1
//
//  Created by Muhammad Usman on 25/7/22.
//

import SwiftUI

struct UnitConverterView: View {
    @State private var input = 0.0
    @State private var outputUnit = "Seconds"
    @State private var inputUnit = "Minutes"
    
    var outputValue: Double {
        var inputSeconds = 0.0
        var outputValue = 0.0
        switch inputUnit {
        case "Hours":
            inputSeconds = input * 60 * 60
            break
        case "Minutes":
            inputSeconds = input * 60
            break
        default:
            inputSeconds = input
        }
        
        switch outputUnit {
        case "Hours":
            outputValue = (inputSeconds / 60) / 60
            break
        case "Minutes":
            outputValue = inputSeconds / 60
            break
        default:
            outputValue = inputSeconds
        }
        
        return outputValue
    }
    
    var units = ["Seconds", "Minutes", "Hours"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select input unit", selection: $inputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.inline)
                } header: {
                    Text("Select input unit")
                }
                
                Section {
                    TextField("Input number", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Enter input here")
                }
                
                Section {
                    Picker("Select output unit", selection: $outputUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Select output unit")
                }
                
                Section {
                    Text("\(outputValue.formatted())")
                } header: {
                    Text("Output")
                }
            }
        }
    }
}

struct UnitConverterView_Previews: PreviewProvider {
    static var previews: some View {
        UnitConverterView()
    }
}
