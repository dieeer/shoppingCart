//
//  Cashier.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

class Cashier {
    private let cart: ShoppingCart
    private let discounter: Discounting?
    
    init(cart: ShoppingCart, discounter: Discounting? = nil) {
        self.cart = cart
        self.discounter = discounter
    }
    
    func applyDiscountToCart(discount: Decimal) {
        discounter?.apply(discount: discount, toCart: cart)
    }
    
    func applyDiscountToProduct(productId: String, discount: Decimal) {
        if let product = cart.products.first(where: { $0.id == productId }) {
            discounter?.apply(discount: discount, toProduct: product)
        }
    }
    
    func applyBuyTwoGetOneFree(category: Category) {
        discounter?.applyBuyTwoGetOneFree(to: cart, for: category)
    }
    
    func applyComboDeal(promotion: Promotion) {
        discounter?.applyComboDeal(to: cart, for: promotion)
    }
    
    func showCart() -> [String: Decimal] {
        var result = [String: Decimal]()
        for product in cart.products {
            result[product.name] = product.price
        }
        return result
    }
}
