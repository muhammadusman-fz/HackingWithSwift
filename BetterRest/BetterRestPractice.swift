//
//  BetterRestPractice.swift
//  WeSplit-Project-1
//
//  Created by Muhammad Usman on 27/7/22.
//

import SwiftUI

struct BetterRestPractice: View {
    @State private var sleepAmount = 3.0
    @State private var wakeupTime = Date.now
    
    var body: some View {
        ZStack {
            AngularGradient(gradient: Gradient(colors: [.blue, .purple, .red, .green, .mint, .yellow, .red, .orange]), center: .center)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 20) {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...8, step: 0.5)
                        .padding()
                 
                    DatePicker("Please enter a date:",
                               selection: $wakeupTime,
                               in: Date.now...,
                               displayedComponents: .date)
                        .labelsHidden()
                    
                    
                }
                .font(.headline.bold())
                .foregroundColor(.white)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding()
        }
    }
}

struct BetterRestPractice_Previews: PreviewProvider {
    static var previews: some View {
        BetterRestPractice()
    }
}
