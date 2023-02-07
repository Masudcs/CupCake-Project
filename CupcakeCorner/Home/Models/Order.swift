//
//  Order.swift
//  CupcakeCorner
//
//  Created by Md. Masud Rana on 2/4/23.
//

import Foundation

struct Order: Codable {
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }

    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || isInputFieldOnlySpace(name) || streetAddress.isEmpty || isInputFieldOnlySpace(streetAddress) || city.isEmpty || isInputFieldOnlySpace(city) || zip.isEmpty || isInputFieldOnlySpace(zip) {
            return false
        } else {
            return true
        }
    }
    
    var cost: Double {
        // $2 per cake
        
        var cost = Double(quantity) * 2
        
        // Complicated cakes cost more
        cost += (Double(type) / 2)
        
        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // $0.50/cake for sprinkless
        
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
      
    func isInputFieldOnlySpace(_ item: String) -> Bool {
        String(Set(item)) == " "
    }
}
