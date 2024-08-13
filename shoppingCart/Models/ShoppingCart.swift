//
//  ShoppingCart.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

protocol ShoppingCarting {
    func add(item: Product)
    func removeItem()
}

class ShoppingCart: ShoppingCarting {
    var products: [Product] = []
    
}
