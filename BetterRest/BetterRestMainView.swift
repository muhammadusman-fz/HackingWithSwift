//
//  BetterRestMainView.swift
//
//  Created by Muhammad Usman on 27/7/22.
//

import CoreML
import SwiftUI

struct BetterRestMainView: View {
    @State private var wakeUpTime = defaultWakeUpTime
    @State private var sleepAmount = 4.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeUpTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                RadialGradient(gradient: Gradient(colors: [.mint, .blue, .secondary]), center: .center, startRadius: 200, endRadius: 5)
                    .ignoresSafeArea()
                
                VStack {
                    VStack {
                        Text("When do you want to wake up?")
                            .font(.headline)
                        DatePicker("Please enter a time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                        
                        Text("Desired amount of sleep?")
                            .font(.headline)
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.5)
                            .padding(.horizontal, 20)
                        
                        Text("Daily coffee intake")
                            .font(.headline)
                        Stepper(coffeeAmount == 1 ? "1 cup" : "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...6 )
                            .padding(.horizontal, 20)
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
                .padding()
                .alert(alertTitle, isPresented: $showingAlert) {
                    Button("OK") { }
                } message: {
                    Text(alertMessage)
                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
        }
    }
    
    func calculateBedTime() {
        do {
          let config = MLModelConfiguration()
          let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUpTime - prediction.actualSleep
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a error in calculating your bed time"
            
        }
        showingAlert = true
        
    }
}

struct BetterRestMainView_Previews: PreviewProvider {
    static var previews: some View {
        BetterRestMainView()
    }
}
