//
//  ShoppingCart.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

protocol ShoppingCarting {
    var products: [Product] { get set }
}

class ShoppingCart: ShoppingCarting {

    var products: [Product] = []
    
    init(products: [Product] = []) {
        self.products = products
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
