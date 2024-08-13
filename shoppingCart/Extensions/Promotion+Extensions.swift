//
//  Promotion+Extensions.swift
//  shoppingCart
//
//  Created by Justin Reid on 13/08/2024.
//

import Foundation

extension Promotion {
    
    static let mockPromotion = Promotion(
        name: "Complete Car Package",
        requiredItems: [.mockProduct1, .mockProduct2, .mockProduct3],
        setPrice: 300.00
    )
}
