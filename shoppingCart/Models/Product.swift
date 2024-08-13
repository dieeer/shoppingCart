//
//  Product.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

enum Category {
    case suspension
    case exhaust
    case transmission
    case interior
}

class Product {
    let id: String
    let category: Category
    let name: String
    let SKU: String
    var price: Decimal
    var discountApplied: Bool = false 
    
    init(id: String, category: Category, name: String, SKU: String, price: Decimal) {
        self.id = id
        self.category = category
        self.name = name
        self.SKU = SKU
        self.price = price
    }
}

struct Promotion {
    let name: String
    let requiredItems: [Product]
    let setPrice: Decimal
}
