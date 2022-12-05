//
//  StepperField.swift
//  PantryManager
//
//  Created by Davide Andreoli on 03/12/22.
//

import SwiftUI

struct StepperField: View {
    @Binding var stepperValue: Double
    
    
    var body: some View {
        HStack {
            Text("Quantity:")
            TextField("Enter Value", value: $stepperValue, formatter: NumberFormatter())
            Stepper(value: $stepperValue, in: 0...Double.infinity, step: 1) {
            }
        }
    }
}

struct StepperField_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            StepperField(stepperValue: .constant(3))
        }
    }
}
