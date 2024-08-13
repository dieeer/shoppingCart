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
    
    var category: Category
    var name: String
    var SKU: String
    var price: Decimal
}
