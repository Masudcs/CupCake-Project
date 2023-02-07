//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Md. Masud Rana on 2/5/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var viewModel: SharedOrder
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $viewModel.data.name)
                TextField("Street Address", text: $viewModel.data.streetAddress)
                TextField("City", text: $viewModel.data.city)
                TextField("Zip", text: $viewModel.data.zip)
            }
            
            Section {
                NavigationLink {
                    CheckoutView(viewModel: viewModel)
                } label: {
                    Text("Check out")
                }

            }
            .disabled(viewModel.data.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(viewModel: SharedOrder())
        }
    }
}
