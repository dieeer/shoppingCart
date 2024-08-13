//
//  ShoppingCart.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

protocol ShoppingCarting {
    var products: [Product] { get set }
    
    func add(item: Product)
    func removeItem(with id: String)
    func clearCart()
}

class ShoppingCart: ShoppingCarting {

    var discounter: Discounting?
    var products: [Product] = []
    
    init(discounter: Discounting? = nil, products: [Product] = []) {
        self.discounter = discounter
    }
    
    var totalPrice: Decimal {
        return products.reduce(0) { $0 + $1.price }
    }
    
    func add(item: Product) {
        products.append(item)
    }
    
    func removeItem(with id: String) {
        products.removeAll { $0.id == id }
    }
    
    func clearCart() {
        products = []
    }
}
