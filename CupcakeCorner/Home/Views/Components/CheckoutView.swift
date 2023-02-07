//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Md. Masud Rana on 2/5/23.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var viewModel: SharedOrder
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var isAlertShowing = false

    var body: some View {
        VStack {
            AsyncImage(
                url: URL(string: "https:hws.dev/img/cupcakes@3x.jpg"),
                scale: 3)
            { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 233)

            Text("Your total is \(viewModel.data.cost, format: .currency(code: "USD"))")
                .font(.title)

            Button("Place Order") {
                Task {
                    await placeOrder()
                }
            }
                .padding()
            Spacer()
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("Ok") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Network Error", isPresented: $isAlertShowing) {
            Button("Retry") {
                Task {
                    await placeOrder()
                }
            }
            
            Button("Cancel") {}
        } message: {
            Text(errorMessage)
        }
    }
    
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(viewModel.data) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpMethod = "POST"
        
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Your order for \(decodedOrder.quantity)x \(SharedOrder.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true
        } catch {
            errorMessage = "\(error)"
            isAlertShowing = true
            print("checkout failed")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(viewModel: SharedOrder())
    }
}
