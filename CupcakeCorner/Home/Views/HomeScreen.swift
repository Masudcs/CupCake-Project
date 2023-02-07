//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Md. Masud Rana on 2/4/23.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject var viewModel = SharedOrder()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $viewModel.data.type) {
                        ForEach(SharedOrder.types.indices) {
                            Text(SharedOrder.types[$0])
                        }
                    }

                    Stepper("Number of cakes:  \(viewModel.data.quantity)", value: $viewModel.data.quantity, in: 3 ... 20)
                }

                Section {
                    Toggle("Any special request", isOn: $viewModel.data.specialRequestEnabled.animation())

                    if viewModel.data.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $viewModel.data.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $viewModel.data.addSprinkles)
                    }
                }

                Section {
                    NavigationLink {
                        AddressView(viewModel: viewModel)
                    } label: {
                        Text("Delivery Details")
                    }
                }
            }
            .navigationTitle("CupCake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
