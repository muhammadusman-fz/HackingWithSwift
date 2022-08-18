//
//  CupcakeCornerMainView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 4/8/2022.
//

import SwiftUI

struct CupcakeCornerMainView: View {
    
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Type", selection: $order.order.type) {
                        ForEach(Order1.types.indices) {
                            Text(Order1.types[$0])
                        }
                    }
                    
                    Stepper("Number of cake: \(order.order.quantity)", value: $order.order.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special request?", isOn: $order.order.specialRequest.animation(.easeIn(duration: 2)))
                    
                    if order.order.specialRequest {
                        Toggle("Add extra frosting", isOn: $order.order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.order.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddressView(currentOrder: order)
                    } label: {
                        Text("Address details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct CupcakeCornerMainView_Previews: PreviewProvider {
    static var previews: some View {
        CupcakeCornerMainView()
    }
}
