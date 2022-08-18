//
//  CheckoutView.swift
//  HackingWithSwift
//
//  Created by Muhammad Usman on 5/8/2022.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    @State private var showingConfirmation = false
    @State private var confirmationMessage = ""
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your totoal cost of \(order.order.quantity) \(Order1.types[order.order.type].lowercased()) cake is: \(order.order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                    .padding()
                
                Button("Place Order ") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .border(.ultraThickMaterial)
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order1.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity) \(Order1.types[decodedOrder.type].lowercased()) cake(s) is on its way to \(order.order.address)"
            showingConfirmation.toggle()
        } catch {
            print("Checkout failed.")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CheckoutView(order: Order())
        }
    }
}
