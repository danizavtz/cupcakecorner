//
//  Order.swift
//  cupcakecorner
//
//  Created by Daniel Lucena Pires on 07/05/23.
//

import SwiftUI

class Order: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprikles, name, streeetAddress, city ,zip
    }
    static let types = ["Baunilha", "Strawberry", "Chocolate", "Arco Íris"]
    @Published  var type = 0
    @Published var quantity = 3
    @Published var specialRequestsEnabled = false {
        didSet {
            if specialRequestsEnabled == false {
                extraFrosting = false
                addSprikles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprikles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var zip = ""
    
    var hasValidAddress : Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprikles {
            cost += Double(quantity) / 2
        }

        return cost
    }
    
    init() {}
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprikles, forKey: .addSprikles)
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streeetAddress)
        try container.encode(city, forKey:.city)
        try container.encode(zip, forKey: .zip)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprikles = try container.decode(Bool.self, forKey: .addSprikles)
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode (String.self, forKey: .streeetAddress)
        city = try  container.decode(String.self, forKey: .city)
        zip = try container.decode(String.self, forKey: .zip)
    }
    
}
