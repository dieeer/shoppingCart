//
//  Product+Extensions.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

extension Product {
    
    static let mockProduct1 = Product(
        id: "001",
        category: .suspension,
        name: "Shock Absorber",
        SKU: "SHK123",
        price: 199.99
    )

    static let mockProduct2 = Product(
        id: "002",
        category: .exhaust,
        name: "Performance Muffler",
        SKU: "PMF456",
        price: 299.99
    )

    static let mockProduct3 = Product(
        id: "003",
        category: .transmission,
        name: "Clutch Kit",
        SKU: "CLT789",
        price: 349.99
    )

    static let mockProduct4 = Product(
        id: "004",
        category: .interior,
        name: "Leather Seat Covers",
        SKU: "LSC012",
        price: 149.99
    )

    static let mockProduct5 = Product(
        id: "005",
        category: .interior,
        name: "Floor Mats",
        SKU: "FM345",
        price: 59.99
    )
}
