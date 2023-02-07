//
//  SharedOrder.swift
//  CupcakeCorner
//
//  Created by Md. Masud Rana on 2/7/23.
//

import SwiftUI

//@dynamicMemberLookup // This attribute allows us to dynamically handle access properties that don't directly exist. Yes, it's a bit confusing.

class SharedOrder: ObservableObject {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    @Published var data = Order() // Creates an instance of our order struct

//    subscript<T>(dynamicMember keyPath: KeyPath<Order, T>) -> T { // This adds a custom subscript using a dynamic member keyPath.
//        data[keyPath: keyPath]
//    }
//
//    subscript<T>(dynamicMember keyPath: WritableKeyPath<Order, T>) -> T {
//        get {
//            data[keyPath: keyPath]
//        }
//
//        set {
//            data[keyPath: keyPath] = newValue
//        }
//    }

}
