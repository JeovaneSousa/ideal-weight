//
//  ContentView.swift
//  ideal-weight
//
//  Created by Jeovane Barbosa on 27/02/23.
//

import SwiftUI

enum WeightRange: String {
    case higher, lower, mean
}
struct ContentView: View {
    
    @State private var weight: Double = 65
    @State private var height: Double = 1.60
    @State private var selectedWeightRange: WeightRange = .lower
    @FocusState private var hasFocus: Bool
    
    private var idealWeightRange: [WeightRange] = [.lower, .mean, .higher]
    
    private var imc: Decimal {
        return Decimal(weight / (height * height))
    }
    
    private var diagnosis: String {
        switch imc {
            case ..<18.5:
                return "Underweight"
            case ..<25:
                return "Healthy Weight"
            case ..<30:
                return "OverWeight"
            default:
                return "Obese"
        }
    }
    
    private var idealWeight: Decimal {
        switch selectedWeightRange {
        case .lower:
            return Decimal(18.5 * (height * height))
        case .mean:
            return Decimal(22.5 * (height * height))
        case .higher:
            return Decimal(25 * (height * height))
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section("Your Weight:") {
                    TextField("Weight", value: $weight, format: .number.precision(.fractionLength(2)))
                        .keyboardType(.numberPad)
                        .focused($hasFocus)
                }
                
                Section("Your height:") {
                    TextField("Height", value: $height, format: .number.precision(.fractionLength(2)))
                        .keyboardType(.numberPad)
                        .focused($hasFocus)
                }
                
                Section {
                    Picker("Weight Range", selection: $selectedWeightRange) {
                        ForEach(idealWeightRange, id: \.self) {
                            Text($0.rawValue.capitalized)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("What ideal weight range would you like to see ?")
                        .font(.system(size: 11,weight: .light, design: .rounded))
                }
                
                Section("IMC Value") {
                    Text(imc, format: .number.precision(.fractionLength(2)))
                }
                
                Section("Diagnosis") {
                    Text(diagnosis)
                }
                
                Section("Ideal Weight") {
                    Text(idealWeight, format: .number.precision(.fractionLength(2)))
                        .multilineTextAlignment(.center)
                }
            }
            .navigationTitle("Ideal Weight")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        hasFocus = false
                    }
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
