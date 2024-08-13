//
//  Discount.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

protocol Discounting {
    func apply(discount: Int, to cart: ShoppingCart)
    func apply(discount: Int, to product: Product)
    func applyBuyTwoGetOneFree(to cart: ShoppingCart, to category: Category)
    func applyComboDeal(to cart: ShoppingCart, for promotion: Promotion)
}

struct Discounter: Discounting {
    
    func apply(discount: Int, to cart: ShoppingCart) {
        guard cart.products.isEmpty else {
            return
        }
        
    }
}
