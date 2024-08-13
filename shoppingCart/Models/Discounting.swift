//
//  Discount.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

protocol Discounting {
    func apply(discount: Decimal, toCart: ShoppingCart)
    func apply(discount: Decimal, toProduct: Product)
    func applyBuyTwoGetOneFree(to cart: ShoppingCart, for category: Category)
    func applyComboDeal(to cart: ShoppingCart, for promotion: Promotion)
}

struct Discounter: Discounting {
    
    func apply(discount: Decimal, toCart cart: ShoppingCart) {
        for product in cart.products {
            if !product.discountApplied {
                let originalPrice = product.price
                product.price = originalPrice * (1 - discount / 100)
                product.discountApplied = true
            }
        }
    }
    
    func apply(discount: Decimal, toProduct product: Product) {
        if !product.discountApplied {
            let originalPrice = product.price
            product.price = originalPrice * (1 - discount / 100)
            product.discountApplied = true
        }
    }
    
    func applyBuyTwoGetOneFree(to cart: ShoppingCart, for category: Category) {
        let filteredProducts = cart.products.filter { $0.category == category }
        let totalItems = filteredProducts.count
        if totalItems >= 3 {
            let sortedProducts = filteredProducts.sorted { $0.id < $1.id }
            for i in stride(from: 2, to: totalItems, by: 3) {
                if let index = cart.products.firstIndex(where: { $0.id == sortedProducts[i].id }) {
                    if !cart.products[index].discountApplied {
                        cart.products[index].price = 0.00 // sets every third item in category free
                        cart.products[index].discountApplied = true
                    }
                }
            }
        }
    }
    
    func applyComboDeal(to cart: ShoppingCart, for promotion: Promotion) {
        let requiredItemIDs = Set(promotion.requiredItems.map { $0.id })
        let cartItemsInPromotion = cart.products.filter { requiredItemIDs.contains($0.id) }
        let allRequiredItemsInCart = Set(promotion.requiredItems.map { $0.id }).isSubset(of: Set(cartItemsInPromotion.map { $0.id }))
        
        if allRequiredItemsInCart {
            let totalItems = Decimal(promotion.requiredItems.count)
            let setPricePerItem = promotion.setPrice / totalItems
            for product in cart.products where requiredItemIDs.contains(product.id) {
                if !product.discountApplied {
                    if let index = cart.products.firstIndex(where: { $0.id == product.id }) {
                        cart.products[index].price = setPricePerItem
                        cart.products[index].discountApplied = true
                    }
                }
            }
        }
    }
}
