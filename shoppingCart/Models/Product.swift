//
//  Product.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//


enum Category {
    case suspension
    case exhaust
    case transmission
    case interior
}

class Product {
    
    let category: Category
    let name: String
    let SKU: String
    let price: Decimal
}

struct Promotion {
    let name: String
    let requiredItems: [Product]
    let discount: Int
}
