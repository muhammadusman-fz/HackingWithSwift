//
//  AddressView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 5/8/2022.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var currentOrder: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $currentOrder.order.name)
                TextField("Address", text: $currentOrder.order.address)
                TextField("City", text: $currentOrder.order.city)
                TextField("Zip", text: $currentOrder.order.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(order: currentOrder)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(currentOrder.order.hasValidAddress == false)
        }
        .navigationTitle("Address details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(currentOrder: Order())
        }
    }
}
