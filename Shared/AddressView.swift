//
//  AddressView.swift
//  cupcakecorner
//
//  Created by Daniel Lucena Pires on 07/05/23.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Nome", text: $order.name)
                TextField("Endereço", text: $order.streetAddress)
                TextField("Cidade", text: $order.city)
                TextField("Cep", text: $order.zip)
            }
            
            Section{
                NavigationLink {
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)

    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddressView(order: Order())
        }
    }
}
